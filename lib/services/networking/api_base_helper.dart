import 'dart:io';
import 'package:vf_user_flutter_new/constants/config.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_service.dart';
import 'dart:async';
import 'api_exceptions.dart';
import 'package:dio/dio.dart';

class ApiBaseHelper {
  final String _baseUrl = AppConfig.devEndpoint;
  final SharedPreferenceService _sharedPrefService = locator<SharedPreferenceService>();

  Future<dynamic> get(String url) async {
    var authToken = await _sharedPrefService.authToken;
    var options = BaseOptions(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      'login-type': 'custom',
      'auth-type': 'user',
      'Authorization': 'Bearer $authToken',
    });
    Dio _dio = Dio(options);

    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await _dio.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('Api get received!');
    return responseJson;
  }

  Future<dynamic> post(String url, [dynamic body]) async {
    var authToken = await _sharedPrefService.authToken;
    var options = BaseOptions(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      'login-type': 'custom',
      'auth-type': 'user',
      'Authorization': 'Bearer $authToken',
    });
    Dio _dio = Dio(options);

    print('Api Post, url $url');
    var responseJson;
    try {
      var response = await _dio.post(
        _baseUrl + url,
        data: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    // print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    var authToken = await _sharedPrefService.authToken;
    var options = BaseOptions(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      'login-type': 'custom',
      'auth-type': 'user',
      'Authorization': 'Bearer $authToken',
    });
    Dio _dio = Dio(options);

    print('Api Put, url $url');
    print(body);
    var responseJson;
    try {
      final response = await _dio.put(_baseUrl + url, data: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('Api put.');
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var authToken = await _sharedPrefService.authToken;
    var options = BaseOptions(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      'login-type': 'custom',
      'auth-type': 'user',
      'Authorization': 'Bearer $authToken',
    });
    Dio _dio = Dio(options);

    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await _dio.delete(_baseUrl + url);
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('Api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      print('Response: $response');
      if (response.data['success'] == null) {
        return response.data;
      }
      if (response.data['success']) {
        return response.data;
      }
      throw response.data['message'];
    case 400:
      throw BadRequestException(response.data);
    case 401:
      throw UnauthorisedException(response.data);
    case 403:
      throw UnauthorisedException(response.data);
    case 500:
    default:
      throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
