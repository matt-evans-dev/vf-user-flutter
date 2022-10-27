import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/services/networking/auth/auth_service.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_service.dart';

import '../../locator.dart';
import 'login_view.dart';

class SplashViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final SharedPreferenceService _sharedPrefService = locator<SharedPreferenceService>();

  // Future<bool> get isLoggedIn => _sharedPrefService.isLoggedIn;

  void checkLogin(BuildContext context) async {
    bool isLoggedIn = await _sharedPrefService.isLoggedIn;
    if (isLoggedIn) {
      // Navigator.pushReplacementNamed(context, BottomNavView.id);
    } else {
      Navigator.pushReplacementNamed(context, LoginView.id);
    }
  }
}
