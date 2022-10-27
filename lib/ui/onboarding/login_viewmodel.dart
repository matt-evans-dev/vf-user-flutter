import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/services/networking/auth/auth_service.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_service.dart';

import '../../locator.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final SharedPreferenceService _sharedPrefService = locator<SharedPreferenceService>();
  final _navSvc = locator<NavigationService>();

  String countryCode;
  String phoneNumber;
  String password;
  bool isSecure = true;

  void onChangeCountryCode(String value) {
    countryCode = value;
  }

  void onChangePhoneNumber(String value) {
    phoneNumber = value;
  }

  void onChangePassword(String value) {
    password = value;
  }

  void onChangeSecureKeyboard() {
    isSecure = !isSecure;
    notifyListeners();
  }

  void onLogin(BuildContext context) async {
    Map<String, String> payload = {
      'mobile': phoneNumber,
      'password': password,
    };
    try {
      await _authService.login(payload);
      _navSvc.appNavigatorKey.currentState.pop();
    } catch (error) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Login failed'),
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

  void goToSignUp(BuildContext context) {
    // Navigator.pushReplacementNamed(context, SignUpView.id);
    _navSvc.onboardingNavigatorKey.currentState.pushNamed(AppRoutes.signUpRoute);
  }

  void goToForgot(BuildContext context) {
    _navSvc.onboardingNavigatorKey.currentState.pushNamed(AppRoutes.forgotRoute);
  }
}
