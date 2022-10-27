import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/services/networking/auth/auth_service.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_service.dart';
import 'package:vf_user_flutter_new/store/auth_store.dart';

import '../../locator.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final AuthStore _authStore = locator<AuthStore>();
  final SharedPreferenceService _sharedPrefService = locator<SharedPreferenceService>();
  final _navSvc = locator<NavigationService>();

  String firstName;
  String lastName;
  String countryCode;
  String phoneNumber;
  String email;
  String password;
  String otp;
  bool passwordSecure = true;
  bool otpSent = false;
  bool phoneVerified = false;

  void onChangeFirstName(value) {
    firstName = value;
  }

  void onChangeLastName(value) {
    lastName = value;
  }

  void onChangeCountryCode(value) {
    countryCode = value;
  }

  void onChangePhoneNumber(value) {
    phoneNumber = value;
  }

  void onChangeEmail(value) {
    email = value;
  }

  void onChangePassword(value) {
    password = value;
  }

  void togglePasswordSecure() {
    passwordSecure = !passwordSecure;
    notifyListeners();
  }

  void onChangeOTP(value) {
    otp = value;
  }

  String emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'This field can not be empty';
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (!emailValid) {
      return 'Email is not valid';
    }
    return null;
  }

  String emptyValidator(value) {
    if (value == null || value.isEmpty) {
      return 'This field can not be empty';
    }
    return null;
  }

  void onSignUp(BuildContext context, StreamController<ErrorAnimationType> errorController) async {
    if (phoneVerified) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Trying to create account'),
          ),
        );
        await _authService.createUser(firstName, lastName, email, countryCode, phoneNumber, password);
        // navigate login page
        goToLogin(context);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('SignUp failed'),
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
    } else {
      if (otpSent) {
        try {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Trying to verify codes'),
            ),
          );
          await _authService.verifyOTPSignUp(phoneNumber, otp);
          phoneVerified = true;
          otpSent = false;
          notifyListeners();
        } catch (error) {
          errorController.add(ErrorAnimationType.shake);
        }
      } else {
        try {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Trying to send verify code to your phone'),
            ),
          );
          await _authService.sendOTPSignUp(phoneNumber, '+1');
          goToOTP(context);
        } catch (error) {
          await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Sending verify code failed'),
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
  }

  void goToLogin(BuildContext context) {
    _navSvc.onboardingNavigatorKey.currentState.pushNamed(AppRoutes.loginRoute);
  }

  void goToOTP(BuildContext context) {
    otpSent = true;
    notifyListeners();
  }
}
