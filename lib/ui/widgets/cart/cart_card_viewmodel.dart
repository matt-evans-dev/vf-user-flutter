import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/models/home/cart_item_model.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/store/cart_store.dart';
import 'package:vf_user_flutter_new/utils/funcs.dart';

import '../../../locator.dart';

class CartCardViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final _cartStore = locator<CartStore>();
  CartItemModel _cartInfo;
  int quantity;
  StreamSubscription sub;

  CartCardViewModel(CartItemModel data, int index, int merchantIdx) {
    sub = _cartStore.items.listen((items) {
      _cartInfo = items[merchantIdx].merchantCartItems[index];
      quantity = items[merchantIdx].merchantCartItems[index].quantity;
      notifyListeners();
    });
  }

  dispose() {
    sub.cancel();
  }

  void onIncrease(int index, int merchantIdx) {
    if (quantity < _cartInfo.productQuantity) {
      quantity++;
      _cartStore.updateQuantity(index, quantity, merchantIdx);
      notifyListeners();
    } else {
      showToast('Out of stock');
    }
  }

  void onDecrease(int index, int merchantIdx) {
    if (quantity > 1) {
      quantity--;
      _cartStore.updateQuantity(index, quantity, merchantIdx);
      notifyListeners();
    }
  }

  void onRemove(int index, int merchantIdx) {
    _cartStore.removeItem(index, merchantIdx);
  }

  void showFoodDetailView() {
    // _navSvc.navigateToFoodDetail(data);
  }
}
