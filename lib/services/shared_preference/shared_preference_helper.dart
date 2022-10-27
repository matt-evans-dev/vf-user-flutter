import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';

class SharedPreferenceHelper {
  // Shared pref instance:
  final Future<SharedPreferences> _sharedPreference;

  // Constructor:
  SharedPreferenceHelper(this._sharedPreference);

  Future<bool> hasKey(String keyName) async {
    return _sharedPreference.then((preference) {
      return preference.containsKey(keyName);
    });
  }

  Future<List<String>> getStringList(String str) async {
    return _sharedPreference.then((preference) {
      return preference.getStringList(str);
    });
  }

  Future<int> getInt(String keyName) async {
    return _sharedPreference.then((preference) {
      return preference.getInt(keyName);
    });
  }

  Future<String> getString(String keyName) async {
    return _sharedPreference.then((preference) {
      return preference.getString(keyName);
    });
  }

  // Authentication:
  Future<String> get authToken async {
    return _sharedPreference.then((preference) {
      return preference.getString(AppStrings.authToken);
    });
  }

  Future<void> saveAuthToken(String authToken) async {
    return _sharedPreference.then((preference) {
      preference.setString(AppStrings.authToken, authToken);
    });
  }

  Future<void> removeAuthToken() async {
    return _sharedPreference.then((preference) {
      preference.remove(AppStrings.authToken);
    });
  }

  Future<bool> get isLoggedIn async {
    return _sharedPreference.then((preference) {
      return preference.getBool(AppStrings.isLoggedIn) ?? false;
    });
  }

  Future<void> saveIsLoggedIn(bool value) async {
    await Future.delayed(Duration(seconds: 1));
    return _sharedPreference.then((preference) {
      preference.setBool(AppStrings.isLoggedIn, value);
    });
  }

  // Notification:
  Future<String> get fcmToken async {
    return _sharedPreference.then((preference) {
      return preference.getString(AppStrings.fcmToken);
    });
  }

  Future<void> saveFCMToken(String fcmToken) async {
    return _sharedPreference.then((preference) {
      preference.setString(AppStrings.fcmToken, fcmToken);
    });
  }

  // Theme:
  Future<bool> get isDarkMode {
    return _sharedPreference.then((prefs) {
      return prefs.getBool(AppStrings.isDarkMode) ?? false;
    });
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool(AppStrings.isDarkMode, value);
    });
  }

  // Cart:
  Future<String> get cartItems async {
    return _sharedPreference.then((preference) {
      return preference.getString(AppStrings.cartItems);
    });
  }

  Future<void> changeCartItems(String value) {
    return _sharedPreference.then((preference) {
      preference.setString(AppStrings.cartItems, value);
    });
  }

  // Location, latitude, longitude
  Future<String> get location async {
    return _sharedPreference.then((preference) {
      return preference.getString(AppStrings.location);
    });
  }

  Future<void> saveLocation(String authToken) async {
    return _sharedPreference.then((preference) {
      preference.setString(AppStrings.location, authToken);
    });
  }

  Future<void> saveLatitude(double value) {
    return _sharedPreference.then((prefs) {
      return prefs.setDouble(AppStrings.latitude, value);
    });
  }

  Future<double> get latitude {
    return _sharedPreference.then((prefs) {
      return prefs.getDouble(AppStrings.latitude);
    });
  }

  Future<void> saveLongitude(double value) {
    return _sharedPreference.then((prefs) {
      return prefs.setDouble(AppStrings.longitude, value);
    });
  }

  Future<double> get longitude {
    return _sharedPreference.then((prefs) {
      return prefs.getDouble(AppStrings.longitude);
    });
  }
}
