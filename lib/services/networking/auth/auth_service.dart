import 'package:dio/dio.dart';
import 'package:vf_user_flutter_new/models/auth/user.dart';
import 'package:vf_user_flutter_new/services/networking/auth/auth_api.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_service.dart';
import 'package:vf_user_flutter_new/store/auth_store.dart';

import '../../../locator.dart';

class AuthService {
  AuthApi _api = locator<AuthApi>();
  final AuthStore _authStore = locator<AuthStore>();
  final SharedPreferenceService _sharedPrefService = locator<SharedPreferenceService>();

  Future<String> login(dynamic body) async {
    try {
      var response = await _api.login(body);
      var authToken = response['accessToken'];
      var refreshToken = response['refreshToken'];
      var userId = response['_id'];
      await _sharedPrefService.saveAuthToken(authToken);
      await _sharedPrefService.saveIsLoggedIn(true);
      String fcmToken = await _sharedPrefService.fcmToken;
      print('fcmToken: $fcmToken');
      await updateFCMToken(fcmToken, userId);
      _authStore.changeAuthState(true);
      await getUserDetail();
      return 'Login Success';
    } catch (error) {
      throw error;
    }
  }

  Future<User> getUserDetail() async {
    try {
      var response = await _api.getUser();
      if (response['user_details'] == null) {
        throw response['message'];
      }
      var user = _authStore.setUserDetail(response['user_details']);
      return user;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateFCMToken(fcmToken, _id) async {
    Map<String, dynamic> body = {
      "userDetails": {"fcmToken": fcmToken, "_id": _id}
    };
    try {
      await _api.updateUser(body);
      return 'Updating FCM Token Success';
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String> updateUserEmail(_id, email) async {
    var body = {
      'userDetails': {
        '_id': _id,
        'email': email,
      }
    };
    try {
      await _api.updateUser(body);
      return 'Updating User Detail Success';
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String> updatePassword(_id, oldPassword, newPassword) async {
    var body = {
      'userDetails': {
        '_id': _id,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }
    };
    try {
      await _api.updateUser(body);
      return 'Updating User Detail Success';
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String> sendOTPChangeMobile(String userName, String mobile, String _id) async {
    Map<String, dynamic> body = {"userName": userName, "user_id": _id, "type": "user", "mobile": mobile, "verifyMobile": true};
    try {
      await _api.sendOTP(body);
      return 'Verify code has been sent';
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String> updateMobile(String _id, String newMobile, String userName, String token, String otp) async {
    Map<String, dynamic> body = {
      "userDetails": {
        "_id": _id,
        "token": token,
        "mobile": newMobile,
        "otp": otp,
        "name": userName,
      }
    };
    try {
      await _api.updateUser(body);
      return 'Updating Mobile Success';
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String> changeProfilePic(_id, filePath) async {
    var formData = FormData.fromMap({
      'name': _id,
      'folder': 'user',
      'file': await MultipartFile.fromFile(
        filePath,
        // filename: 'upload.txt',
      ),
    });
    try {
      await _api.updateProfilePic(formData, _id);
      return 'Updating User Profile Picture Success';
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String> sendRecoveryCode(String mobile) async {
    Map<String, String> body = {
      'mobile': mobile,
    };
    try {
      var response = await _api.sendOTPForgotPassword(body);
      return response['token'];
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String> resetPassword(String mobile, String token, String pwd, String otp) async {
    Map<String, String> body = {"mobile": mobile, "password": pwd, "token": token, "otp": otp};
    try {
      await _api.resetPassword(body);
      return 'Reset Password Success';
    } catch (error) {
      print(error.message);
      throw error.message;
    }
  }

  Future<dynamic> sendOTPSignUp(String mobile, String countryCode) async {
    Map<String, dynamic> body = {"signup": true, "mobile": mobile, "countryCode": countryCode};
    try {
      var response = await _api.sendOTP(body);
      return response['token'];
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> verifyOTPSignUp(String mobile, String otp) async {
    Map<String, dynamic> body = {"otp": otp, "mobile": mobile};
    try {
      await _api.verifyOTPSignUp(body);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String> createUser(firstName, lastName, email, countryCode, mobile, password) async {
    Map<String, dynamic> body = {
      "userDetails": {
        "userName": firstName + " " + lastName,
        "email": email,
        "countryCode": countryCode,
        "mobile": mobile,
        "password": password,
        "loginType": 'custom',
        "signupType": 'custom',
      }
    };
    try {
      await _api.createUser(body);
      return 'Sign up success';
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
