import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/auth/user.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/routes/onboarding_navigator.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/services/networking/auth/auth_service.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_service.dart';
import 'package:vf_user_flutter_new/store/auth_store.dart';
import 'package:vf_user_flutter_new/store/theme_store.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

class AccountViewModel extends FutureViewModel {
  final _navSvc = locator<NavigationService>();
  final ThemeStore _themeStore = locator<ThemeStore>();
  final AuthStore _authStore = locator<AuthStore>();
  final AuthService _authService = locator<AuthService>();
  final SharedPreferenceService _sharedPrefService = locator<SharedPreferenceService>();

  bool isDarkMode = false;
  bool isLoggedIn = false;
  User userDetail = new User();
  User userDetailEdited = new User();
  String currentPassword;
  String newPassword;
  String confirmPassword;
  String otp;
  String otpToken;
  bool currentPasswordSecure = true;
  bool newPasswordSecure = true;
  bool confirmPasswordSecure = true;
  bool otpSent = false;

  AccountViewModel();

  void changeTheme(bool value) async {
    isDarkMode = value;
    notifyListeners();
    await _sharedPrefService.changeBrightnessToDark(value);
    Future.delayed(Duration(microseconds: 500)).then((_) => _themeStore.updateTheme(value));
  }

  void onLogout(BuildContext context) async {
    isLoggedIn = false;
    notifyListeners();
    await _sharedPrefService.saveIsLoggedIn(false);
    await _sharedPrefService.removeAuthToken();
    _authStore.changeAuthState(false);
    _authStore.removeUserDetail();
  }

  void goToSignUp(BuildContext context) {
    OnboardingNavArgs args = OnboardingNavArgs(AppRoutes.signUpRoute);
    _navSvc.navigateToRootView(AppRoutes.onboardingRoute, arg: args);
  }

  void goToLogin(BuildContext context) {
    OnboardingNavArgs args = OnboardingNavArgs(AppRoutes.loginRoute);
    _navSvc.navigateToRootView(AppRoutes.onboardingRoute, arg: args);
  }

  void goToAccountManage(BuildContext context) {
    OnboardingNavArgs args = OnboardingNavArgs(AppRoutes.manageAccountRoute);
    _navSvc.navigateToRootView(AppRoutes.onboardingRoute, arg: args);
  }

  void goToPaymentManage(BuildContext context) {
    OnboardingNavArgs args = OnboardingNavArgs(AppRoutes.managePaymentRoute);
    _navSvc.navigateToRootView(AppRoutes.onboardingRoute, arg: args);
  }

  void goBack(BuildContext context) {
    _navSvc.appNavigatorKey.currentState.pop();
  }

  void onSave(BuildContext context, StreamController<ErrorAnimationType> errorController) async {
    if (userDetailEdited.email == userDetail.email &&
        userDetailEdited.mobile == userDetail.mobile &&
        (currentPassword == null || currentPassword.isEmpty)) {
      // nothing has been changed. ignore the activity
      _navSvc.appNavigatorKey.currentState.pop();
      return;
    }

    try {
      if (userDetailEdited.mobile != userDetail.mobile) {
        // mobile has been changed. need to verify new number
        if (!otpSent) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Trying to send code to new mobile number')));
          otpToken = await _authService.sendOTPChangeMobile(userDetail.userName, userDetailEdited.mobile, userDetail.userId);
          otpSent = true;
          notifyListeners();
          return;
        } else {
          if (otp == null || otp.length != 6) {
            errorController.add(ErrorAnimationType.shake);
            return;
          }
          await _authService.updateMobile(userDetailEdited.userId, userDetailEdited.mobile, userDetail.userName, otpToken, otp);
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Trying to update account')));
      if (userDetailEdited.email != userDetail.email) {
        // email has been changed
        await _authService.updateUserEmail(userDetailEdited.userId, userDetailEdited.email);
      }
      if (currentPassword.isNotEmpty) {
        // change password
        await _authService.updatePassword(userDetailEdited.userId, currentPassword, newPassword);
      }
      _navSvc.appNavigatorKey.currentState.pop();
    } catch (error) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Updating failed'),
          content: Text(error.toString()),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: false).pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void onChangeUserName(String newUserName) {
    userDetailEdited.userName = newUserName;
  }

  void onChangeEmail(String newEmail) {
    userDetailEdited.email = newEmail;
  }

  void onChangeMobile(String newMobile) {
    userDetailEdited.mobile = newMobile;
  }

  void onChangeOTP(String value) {
    otp = value;
  }

  void onChangeCurrentPassword(String value) {
    currentPassword = value;
  }

  void onChangeNewPassword(String value) {
    newPassword = value;
  }

  void onChangeConfirmPassword(String value) {
    confirmPassword = value;
  }

  void onToggleCurrentPasswordSecure() {
    currentPasswordSecure = !currentPasswordSecure;
    notifyListeners();
  }

  void onToggleNewPasswordSecure() {
    newPasswordSecure = !newPasswordSecure;
    notifyListeners();
  }

  void onToggleConfirmPasswordSecure() {
    confirmPasswordSecure = !confirmPasswordSecure;
    notifyListeners();
  }

  String emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please input new email';
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (!emailValid) {
      return 'Email is not valid';
    }
    return null;
  }

  String mobileValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please input new mobile number';
    }
    return null;
  }

  String currentPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      if ((newPassword == null || newPassword.isEmpty) && (confirmPassword == null || confirmPassword.isEmpty)) {
        return null;
      }
      return 'Please input current password';
    }
    return null;
  }

  String newPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      if ((currentPassword == null || currentPassword.isEmpty) && (confirmPassword == null || confirmPassword.isEmpty)) {
        return null;
      }
      return 'Please input new password';
    }
    if (value != confirmPassword) {
      return 'New password is not matched';
    }
    return null;
  }

  String confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      if ((currentPassword == null || currentPassword.isEmpty) && (newPassword == null || newPassword.isEmpty)) {
        return null;
      }
      return 'Please input new password again';
    }
    if (value != newPassword) {
      return 'New password is not matched';
    }
    return null;
  }

  void getImage(BuildContext context) {
    final picker = ImagePicker();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Pick Image'),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Use Camera'),
            onPressed: () async {
              final pickedFile = await picker.getImage(source: ImageSource.camera);
              handleFileData(context, pickedFile);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Select from phone'),
            onPressed: () async {
              final pickedFile = await picker.getImage(source: ImageSource.gallery);
              handleFileData(context, pickedFile);
            },
          ),
        ],
      ),
    );
  }

  Future<void> handleFileData(BuildContext context, PickedFile pickedFile) async {
    if (pickedFile != null) {
      print(pickedFile.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Trying to update profile picture'),
        ),
      );
      Navigator.pop(context);
      try {
        await _authService.changeProfilePic(userDetail.userId, pickedFile.path);
        var user = await _authService.getUserDetail();
        userDetailEdited = user;
        notifyListeners();
      } catch (error) {
        print(error);
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Future<String> futureToRun() => getDataFromServer();

  Future<String> getDataFromServer() async {
    String message = 'Success';
    try {
      var user = await _authService.getUserDetail();
      userDetailEdited = user;
    } catch (error) {
      message = error;
    }
    _authStore.userDetail.listen((x) => userDetail = x);
    _themeStore.isDarkTheme.listen((x) => isDarkMode = x);
    _authStore.isLoggedIn.listen((x) => isLoggedIn = x);
    return message;
  }
}
