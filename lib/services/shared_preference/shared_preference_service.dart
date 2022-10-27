import 'package:shared_preferences/shared_preferences.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_helper.dart';

class SharedPreferenceService {
  // Shared pref object:
  SharedPreferenceHelper sharedPrefHelper;

  SharedPreferenceService() {
    Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();
    sharedPrefHelper = SharedPreferenceHelper(sharedPref);
  }

  Future<bool> hasKey(String keyName) => sharedPrefHelper.hasKey(keyName);

  Future<List<String>> getStringList(String str) => sharedPrefHelper.getStringList(str);

  Future<int> getInt(String keyName) => sharedPrefHelper.getInt(keyName);

  Future<String> getString(String keyName) => sharedPrefHelper.getString(keyName);

  // Authentication:
  Future<void> saveIsLoggedIn(bool value) => sharedPrefHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => sharedPrefHelper.isLoggedIn;

  Future<void> saveAuthToken(String token) => sharedPrefHelper.saveAuthToken(token);

  Future<void> removeAuthToken() => sharedPrefHelper.removeAuthToken();

  Future<String> get authToken => sharedPrefHelper.authToken;

  // Notification:
  Future<void> saveFCMToken(String fcmToken) => sharedPrefHelper.saveFCMToken(fcmToken);

  Future<String> get fcmToken => sharedPrefHelper.fcmToken;

  // Theme:
  Future<void> changeBrightnessToDark(bool value) => sharedPrefHelper.changeBrightnessToDark(value);

  Future<bool> get isDarkMode => sharedPrefHelper.isDarkMode;

  // Cart:
  Future<void> changeCartItems(String value) => sharedPrefHelper.changeCartItems(value);

  Future<String> get cartItems => sharedPrefHelper.cartItems;

  // Location, Latitude, longitude:
  Future<void> saveLocation(String location) => sharedPrefHelper.saveLocation(location);
  Future<String> get location => sharedPrefHelper.location;

  Future<void> saveLatitude(double latitude) => sharedPrefHelper.saveLatitude(latitude);
  Future<double> get latitude => sharedPrefHelper.latitude;

  Future<void> saveLongitude(double longitude) => sharedPrefHelper.saveLongitude(longitude);
  Future<double> get longitude => sharedPrefHelper.longitude;
}
