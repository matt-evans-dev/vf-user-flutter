import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/auth/user.dart';
import 'package:vf_user_flutter_new/models/customer_card/customer_card.dart';
import 'package:vf_user_flutter_new/models/home/cart_item_model.dart';
import 'package:vf_user_flutter_new/models/order/order_response.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/services/networking/order/order_service.dart';
import 'package:vf_user_flutter_new/services/networking/payment/payment_service.dart';
import 'package:vf_user_flutter_new/store/auth_store.dart';
import 'package:vf_user_flutter_new/store/cart_store.dart';

class ConfirmOrderViewModel extends FutureViewModel {
  final _navSvc = locator<NavigationService>();
  final _cartStore = locator<CartStore>();
  final _authStore = locator<AuthStore>();
  final OrderService _orderService = locator<OrderService>();
  final PaymentService _paymentService = locator<PaymentService>();
  List<MerchantCart> items = [];
  List<CustomerCard> cards = [];
  String promoCode;
  bool paymentProcessing = false;

  CustomerCard _selectedCard;
  CustomerCard get selectedCard => _selectedCard;

  bool get cartIsEmpty {
    bool isEmpty = true;
    for (var item in items) {
      if (item.merchantCartItems.length > 0) {
        isEmpty = false;
        break;
      }
    }
    return isEmpty;
  }

  double get totalPrice {
    var price = 0.0;
    items.forEach((item) {
      item.merchantCartItems.forEach((element) {
        price += element.productPrice * element.quantity;
      });
    });
    return price;
  }

  ConfirmOrderViewModel() {
    _cartStore.items.stream.listen((newItems) {
      itemsUpdated(newItems);
    });
    _authStore.userCards.listen((userCards) {
      cards = userCards;
    });
  }

  void itemsUpdated(List<MerchantCart> newItems) {
    items = newItems;
    notifyListeners();
  }

  void onChangePromoCode(value) {
    promoCode = value;
  }

  void onSubmitPromoCode(BuildContext context) {}

  void updatePaymentMethod(CustomerCard value) {
    _selectedCard = value;
    notifyListeners();
  }

  void showAddPayment() {
    _navSvc.navigateToRootView(AppRoutes.addPaymentRoute);
  }

  void confirmOrder(BuildContext context) async {
    if (paymentProcessing) return;
    if (selectedCard == null) {
      Flushbar(
        message: 'Please select your credit card or add new one to make payments',
        duration: Duration(seconds: 4),
      )..show(context);
      return;
    } else {
      if (cartIsEmpty) {
        Flushbar(
          message: 'Your cart is empty',
          duration: Duration(seconds: 3),
        )..show(context);
        return;
      }
      paymentProcessing = true;
      Flushbar(
        message: 'Trying to proceed the payment',
        duration: Duration(seconds: 3),
      )..show(context);
      try {
        User user = await _authStore.userDetail.first;
        items.forEach((item) async {
          // create order
          var price = 0.0;
          item.merchantCartItems.forEach((element) {
            price += element.productPrice * element.quantity;
          });
          double taxAmount = double.parse((price * item.merchant.taxPercent / 100).toStringAsFixed(2));
          double itemTotal = (price + taxAmount);
          OrderResponse orderResponse = await _orderService.createOrder(
            (itemTotal * 100).toInt(),
            item.merchantCartItems.length,
            taxAmount,
            price,
            item.merchantCartItems
                .map((cartItem) => {'id': cartItem.id, 'name': cartItem.productName, 'quantity': cartItem.quantity, 'price': cartItem.productPrice})
                .toList(),
            user.userId,
            item.merchant.id,
            item.merchant.stripeAccountId,
            user.stripeId,
          );
          // make a payment
          await _paymentService.payViaExistingCard(orderResponse, selectedCard);
          // update order
          await _orderService.updateOrder(orderResponse.id, orderResponse.orderId, orderResponse.paymentIntent.id);
        });
        // success
        await _orderService.getOrders(user.userId, 0, 100);
        // clear cart store
        _cartStore.clearItems();
        // navigate to success page
        paymentProcessing = false;
        showOrderSuccess();
      } catch (err) {
        paymentProcessing = false;
        throw err;
      }
    }
  }

  void showOrderSuccess() {
    _navSvc.navigateToRootView(AppRoutes.orderSuccessRoute);
  }

  @override
  Future<String> futureToRun() => getDataFromServer();

  Future<String> getDataFromServer() async {
    String message = 'Success';
    try {
      User user = await _authStore.userDetail.first;
      await _paymentService.getCards(user.stripeId);
    } catch (error) {
      message = error;
    }
    return message;
  }
}
