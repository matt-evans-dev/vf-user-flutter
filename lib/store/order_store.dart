import 'package:rxdart/rxdart.dart';
import 'package:vf_user_flutter_new/models/order/order.dart';

class OrderStore {
  BehaviorSubject<List<Order>> orders;

  OrderStore() {
    orders = BehaviorSubject<List<Order>>.seeded([]);
  }

  void setOrders(List<Order> data) {
    orders.add(data);
  }
}
