import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/services/networking/auth/auth_service.dart';
import 'package:vf_user_flutter_new/ui/onboarding/login_view.dart';

import '../../locator.dart';

class ForgotViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final _navSvc = locator<NavigationService>();

  String countryCode;
  String phoneNumber;
  String token;
  String currentText;
  String password;
  String confirmPassword;
  bool passwordSecure = true;
  bool confirmPasswordSecure = true;

  void onChangePassword(value) {
    password = value;
  }

  void onChangeConfirmPassword(value) {
    confirmPassword = value;
  }

  void togglePasswordSecure() {
    passwordSecure = !passwordSecure;
    notifyListeners();
  }

  void toggleConfirmPasswordSecure() {
    confirmPasswordSecure = !confirmPasswordSecure;
    notifyListeners();
  }

  Future<void> onSubmit(BuildContext context) async {
    print('$phoneNumber $token $currentText $password');
    try {
      token = await _authService.resetPassword(phoneNumber, token, password, currentText);
      Navigator.pushNamedAndRemoveUntil(context, LoginView.id, (Route<dynamic> route) => false);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Resetting password failed'),
          content: Text(error.toString()),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void onChangeCode(value) {
    currentText = value;
  }

  void onContinue(BuildContext context) {
    _navSvc.onboardingNavigatorKey.currentState.pushNamed(AppRoutes.newPwdRoute);
  }

  void onChangeCountryCode(String value) {
    countryCode = value;
  }

  void onChangePhoneNumber(String value) {
    phoneNumber = value;
  }

  void goBack(BuildContext context) {
    _navSvc.onboardingNavigatorKey.currentState.pop();
  }

  Future<void> onGetOTP(BuildContext context) async {
    try {
      token = await _authService.sendRecoveryCode(phoneNumber);
      _navSvc.onboardingNavigatorKey.currentState.pushNamed(AppRoutes.verificationCodeRoute);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Getting recovery code failed'),
          content: Text(error.toString()),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
