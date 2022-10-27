import 'package:vf_user_flutter_new/services/networking/api_base_helper.dart';

class AuthApi {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<dynamic> login(dynamic body) async {
    return _apiBaseHelper.post('auth/login/', body);
  }

  Future<dynamic> getUser() async {
    return _apiBaseHelper.post('user/info', {});
  }

  Future<dynamic> updateUser(dynamic body) async {
    return _apiBaseHelper.put('user/update', body);
  }

  Future<dynamic> updateProfilePic(dynamic formData, String _id) async {
    var awsResponse = await _apiBaseHelper.post('aws/upload', formData);
    var body = {
      'userDetails': {
        '_id': _id,
        'profilePic': awsResponse['Location'],
      }
    };
    await _apiBaseHelper.put('user/update', body);
  }

  Future<dynamic> sendOTPForgotPassword(dynamic body) async {
    return _apiBaseHelper.post('auth/password/recover', body);
  }

  Future<dynamic> resetPassword(dynamic body) async {
    return _apiBaseHelper.post('auth/password/reset', body);
  }

  Future<dynamic> createUser(dynamic body) async {
    return _apiBaseHelper.post('user/create', body);
  }

  Future<dynamic> sendOTP(dynamic body) async {
    return _apiBaseHelper.post('message/mobile', body);
  }

  Future<dynamic> verifyOTPSignUp(dynamic body) async {
    return _apiBaseHelper.post('user/verifyotp', body);
  }
}
