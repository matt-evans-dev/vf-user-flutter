import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/auth/user.dart';
import 'package:vf_user_flutter_new/models/order/order.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/services/networking/order/order_service.dart';
import 'package:vf_user_flutter_new/store/auth_store.dart';
import 'package:vf_user_flutter_new/store/order_store.dart';

class OrderViewModel extends FutureViewModel {
  final _navSvc = locator<NavigationService>();
  final OrderStore _orderStore = locator<OrderStore>();
  final AuthStore _authStore = locator<AuthStore>();
  final OrderService _orderService = locator<OrderService>();

  User userDetail = new User();
  List<Order> orders = [];
  int skip = 0;
  int limit = 100;

  OrderViewModel() {
    _orderStore.orders.listen((x) => orders = x);
    _authStore.userDetail.listen((x) => userDetail = x);
    _authStore.userDetail.stream.listen((event) {
      // user changed. need to fetch again
      if (event.userId == null) {
        return;
      }
      skip = 0;
      limit = 100;
      fetchOrders(event.userId);
    });
  }

  void goBack(BuildContext context) {
    _navSvc.appNavigatorKey.currentState.pop();
  }

  Future<void> fetchOrders(String userId) async {
    try {
      await _orderService.getOrders(userId, skip, limit);
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<String> futureToRun() => getDataFromServer();

  Future<String> getDataFromServer() async {
    String message = 'Success';
    return message;
  }
}
