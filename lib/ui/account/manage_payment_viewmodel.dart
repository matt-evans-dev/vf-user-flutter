import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/enum/payment_method_types.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/auth/user.dart';
import 'package:vf_user_flutter_new/models/customer_card/customer_card.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/loggr.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/services/networking/payment/payment_service.dart';
import 'package:vf_user_flutter_new/store/auth_store.dart';

class ManagePaymentViewModel extends FutureViewModel {
  final _navSvc = locator<NavigationService>();
  final AuthStore _authStore = locator<AuthStore>();
  final PaymentService _paymentService = locator<PaymentService>();

  PaymentMethodTypes _character;
  PaymentMethodTypes get character => _character;
  List<CustomerCard> cards = [];

  ManagePaymentViewModel() {
    _authStore.userCards.listen((x) => cards = x);
  }

  void updatePaymentMethod(PaymentMethodTypes value) {
    _character = value;
    notifyListeners();
  }

  void goBack(BuildContext context) {
    _navSvc.appNavigatorKey.currentState.pop();
  }

  void onSave(BuildContext context) {
    _navSvc.appNavigatorKey.currentState.pop();
  }

  void goToAddPayment(BuildContext context) {
    _navSvc.navigateToRootView(AppRoutes.addPaymentRoute);
  }

  @override
  Future<String> futureToRun() => getDataFromServer();

  Future<String> getDataFromServer() async {
    String message = 'Success';
    try {
      User user = await _authStore.userDetail.first;
      await _paymentService.getCards(user.stripeId);
    } catch (error) {
      logger.e(error);
      message = error;
    }
    return message;
  }
}
