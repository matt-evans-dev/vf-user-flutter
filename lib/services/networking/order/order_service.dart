import 'package:vf_user_flutter_new/models/order/order.dart';
import 'package:vf_user_flutter_new/models/order/order_response.dart';
import 'package:vf_user_flutter_new/services/loggr.dart';
import 'package:vf_user_flutter_new/services/networking/order/order_api.dart';
import 'package:vf_user_flutter_new/store/order_store.dart';
import '../../../locator.dart';

class OrderService {
  OrderApi _api = locator<OrderApi>();
  final OrderStore _orderStore = locator<OrderStore>();

  Future<void> getOrders(String _id, int skip, int limit) async {
    try {
      var response = await _api.getOrders(skip, limit, <String, dynamic>{"user": _id});
      if (response["orders"] != null) {
        List<dynamic> body = response["orders"];
        List<Order> orders = body
            .map(
              (dynamic item) => Order.fromJson(item),
            )
            .toList();
        _orderStore.setOrders(orders);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<OrderResponse> createOrder(
    int totalAmount,
    int totalItems,
    double taxAmount,
    double itemTotal,
    List items,
    String userId,
    String merchantId,
    String merchantStripeId,
    String userStripeId,
  ) async {
    Map<String, dynamic> body = {
      'orderDetails': {
        'description': 'Vuacifood Order',
        'totalAmount': totalAmount,
        'totalItem': totalItems,
        'currencyType': "usd",
        'tax': taxAmount,
        'itemTotal': itemTotal,
        'items': items,
        'user': userId,
        'status': "initiated",
        'merchant': merchantId,
        'stripeAccountId': merchantStripeId,
        'userRating': "5",
        'customerId': userStripeId,
      }
    };
    try {
      var response = await _api.createOrder(body);
      if (response['success']) {
        return OrderResponse.fromJson(response["order"]);
      } else {
        throw response['message'];
      }
    } catch (error) {
      logger.i(error);
      throw error;
    }
  }

  Future<bool> updateOrder(
    String order_Id,
    String orderId,
    String paymentIntentId,
  ) async {
    Map<String, dynamic> body = {
      "orderDetails": {
        "_id": order_Id,
        "id": orderId,
        "status": "success",
        "orderStatus": "pickup pending",
        "paymentIntentId": paymentIntentId,
      }
    };
    print(body);
    try {
      var response = await _api.updateOrder(body);
      if (response["success"] == true) {
        return true;
      } else {
        throw response['message'];
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
