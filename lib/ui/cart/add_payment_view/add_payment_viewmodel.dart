import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/enum/payment_method_types.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';

class AddPaymentViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();

  PaymentMethodTypes _character;
  PaymentMethodTypes get character => _character;

  void updatePaymentMethod(PaymentMethodTypes value) {
    _character = value;
    notifyListeners();
  }

  void showAddPayment() {
    _navSvc.navigateToRootView(AppRoutes.addCardRoute);
  }
}
