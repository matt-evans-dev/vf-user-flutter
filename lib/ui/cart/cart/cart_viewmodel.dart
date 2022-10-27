import 'dart:ffi';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/enum/bottom_tab_items.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/home/cart_item_model.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/store/auth_store.dart';
import 'package:vf_user_flutter_new/store/cart_store.dart';

class CartViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final _cartStore = locator<CartStore>();
  final _authStore = locator<AuthStore>();
  List<MerchantCart> items = [];
  bool isLoggedIn = false;

  bool get cartIsEmpty {
    bool isEmpty = true;
    for (var item in items) {
      if (item.merchantCartItems.length > 0) {
        isEmpty = false;
        break;
      }
    }
    return isEmpty;
  }

  double get totalPrice {
    var price = 0.0;
    items.forEach((item) {
      item.merchantCartItems.forEach((element) {
        price += element.productPrice * element.quantity;
      });
    });
    return price;
  }

  CartViewModel() {
    _cartStore.items.stream.listen((newItems) {
      itemsUpdated(newItems);
    });
    _authStore.isLoggedIn.stream.listen((val) {
      isLoggedIn = val;
    });
  }

  void showConfirmOrder(BuildContext context) {
    if (isLoggedIn != true) {
      // Flushbar(
      //   message: 'You must login to proceed the payment',
      //   duration: Duration(seconds: 4),
      // )..show(context);
      BottomTabItem selCurrTabItem = BottomTabItem.values[4];
      _navSvc.updateCurrentTab(selCurrTabItem);
      return;
    }
    if (items.length > 0) {
      _navSvc.navigateToRootView(AppRoutes.confirmOrderRoute);
    } else {
      Flushbar(
        message: 'Your cart is empty',
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void itemsUpdated(List<MerchantCart> newItems) {
    items = newItems;
    notifyListeners();
  }

  void showContinue() {
    BottomTabItem selCurrTabItem = BottomTabItem.values[0];
    _navSvc.updateCurrentTab(selCurrTabItem);
  }
}
