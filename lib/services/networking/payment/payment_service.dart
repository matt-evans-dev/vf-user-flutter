import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:vf_user_flutter_new/models/customer_card/customer_card.dart';
import 'package:vf_user_flutter_new/models/order/order_response.dart';
import 'package:vf_user_flutter_new/services/loggr.dart';
import 'package:vf_user_flutter_new/services/networking/payment/payment_api.dart';
import 'package:vf_user_flutter_new/store/auth_store.dart';
import 'package:http/http.dart' as http;
import '../../../locator.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class PaymentService {
  PaymentApi _api = locator<PaymentApi>();
  final AuthStore _authStore = locator<AuthStore>();

  static String apiBase = "https://api.stripe.com/v1";
  static String secret = "sk_test_51HD3rnBOXzjYb1SKSCEmcrWJv1Sy5cZGwsONWgNxyocAK6z7Hpabvk5MLZ9aMxs3KVBAVpdCoJhYShzYCsnGFJkr00mp2l3qZE";
  // static String secret =
  //     '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';
  // static String secret = 'sk_test_7pIjDLTq2qryk7IT0hCANoKS';
  static String paymentApiUrl = '$apiBase/payment_intents';
  static const PAYMENT_METHOD_URL = "https://api.stripe.com/v1/payment_methods";
  static Map<String, String> headers = {'Authorization': 'Bearer $secret', 'content-type': 'application/x-www-form-urlencoded'};
  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_51HD3rnBOXzjYb1SKcr0DzivAA2FRUlolg4CAch7MnWPbuBfpM18654t0Oc8ZF6NANOsLWW1DAR0UK0EuyAl7dgrB00ISBwCB1h",
        // publishableKey:
        //     "pk_live_51HD3rnBOXzjYb1SKBNgmyOne8Ct95U9U3e8PKDEMh786pjSKXH6fieceP9MtMGxwWxfUiXM3VHxNSUubIAcpGBV900u3zcoATd",

        // publishableKey: "pk_test_eFrL1qmhojSK0aC9aNlgPfYv",
        merchantId: "",
        androidPayMode: 'test'));
  }

  Future<StripeTransactionResponse> payViaExistingCard(OrderResponse order, CustomerCard card) async {
    CreditCard stripeCard = CreditCard(
      cardId: card.id,
      last4: card.card.last4,
      expMonth: card.card.expMonth,
      expYear: card.card.expYear,
    );
    try {
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
        clientSecret: order.paymentIntent.clientSecret,
        paymentMethodId: stripeCard.cardId,
      ));

      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return PaymentService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }

  Future<String> addCard(String cardNumber, String month, String year, String cvc, String stripeId) async {
    List<dynamic> custPaymentMethods = [];
    Map body = {"type": "card", "card[number]": cardNumber, "card[exp_month]": month, "card[exp_year]": year, "card[cvc]": cvc};
    try {
      var response =
          await Dio().post(PAYMENT_METHOD_URL, data: body, options: Options(contentType: Headers.formUrlEncodedContentType, headers: headers));
      String paymentMethod = response.data["id"];
      var attachCardResponse = await http.get(Uri.parse("https://api.stripe.com/v1/payment_methods?customer=$stripeId&type=card"), headers: headers);
      if (attachCardResponse.reasonPhrase == "OK") {
        custPaymentMethods = jsonDecode(attachCardResponse.body)["data"];

        if (custPaymentMethods.length > 0) {
          for (var item in custPaymentMethods) {
            if (item["card"]["fingerprint"] == response.data["card"]["fingerprint"]) {
              return 'Card already exists';
            }
          }
        }
        attachCardResponse = await http.post(Uri.parse("https://api.stripe.com/v1/payment_methods/$paymentMethod/attach"),
            body: {"customer": stripeId}, headers: headers);
        if (attachCardResponse.reasonPhrase == "OK") {
          return 'success';
        }
      }
      return attachCardResponse.reasonPhrase;
    } catch (err) {
      logger.e("ERROR ATTACHING CARD TO CUSTOMER: ${err.response.toString()}");
      if (err is DioError) {
        return err.response.data['error']['message'].toString();
      } else {
        return err.toString();
      }
    }
  }

  Future<void> getCards(String stripeId) async {
    Map<String, dynamic> body = {
      'customer_id': stripeId,
      'type': "card",
    };
    try {
      var response = await _api.getCards(body);
      _authStore.setUserCards(response);
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
