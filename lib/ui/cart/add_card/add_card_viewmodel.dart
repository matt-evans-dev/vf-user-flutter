import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/auth/user.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/routes/onboarding_navigator.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/services/networking/payment/payment_service.dart';
import 'package:vf_user_flutter_new/store/auth_store.dart';

class AddCardViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final AuthStore _authStore = locator<AuthStore>();
  final PaymentService _paymentService = locator<PaymentService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  User userDetail = new User();

  AddCardViewModel() {
    _authStore.userDetail.listen((value) {
      userDetail = value;
    });
  }

  void updateCardInfo(CreditCardModel creditCardModel) {
    cardNumber = creditCardModel.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    notifyListeners();
  }

  void showOrderSuccess() {
    _navSvc.navigateToRootView(AppRoutes.orderSuccessRoute);
  }

  Future<void> addCard(BuildContext context) async {
    String month = expiryDate.split('/')[0];
    String year = expiryDate.split('/')[1];
    try {
      Flushbar(
        message: 'Trying to add card to your account',
        duration: Duration(seconds: 4),
      )..show(context);
      String response = await _paymentService.addCard(cardNumber, month, year, cvvCode, userDetail.stripeId);
      if (response == 'success') {
        await _paymentService.getCards(userDetail.stripeId);
        _navSvc.appNavigatorKey.currentState.pop();
        _navSvc.appNavigatorKey.currentState.pop();
        return;
      }
      Flushbar(
        message: response,
        duration: Duration(seconds: 3),
      )..show(context);
    } catch (error) {
      Flushbar(
        message: error,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }
}
