import 'package:vf_user_flutter_new/services/networking/api_base_helper.dart';

class OrderApi {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<dynamic> getOrders(skip, limit, body) async {
    return _apiBaseHelper.post('order/data?skip=$skip&limit=$limit', body);
  }

  Future<dynamic> createOrder(dynamic body) async {
    return _apiBaseHelper.post('order/create', body);
  }

  Future<dynamic> updateOrder(dynamic body) async {
    return _apiBaseHelper.post('order/update', body);
  }
}
