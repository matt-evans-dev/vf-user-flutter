import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/home/cart_item_model.dart';
import 'package:vf_user_flutter_new/models/home/merchant_model.dart';
import 'package:vf_user_flutter_new/services/loggr.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_service.dart';
import 'package:vf_user_flutter_new/utils/funcs.dart';

class CartStore {
  final SharedPreferenceService _sharedPrefService = locator<SharedPreferenceService>();
  BehaviorSubject<List<MerchantCart>> items = BehaviorSubject<List<MerchantCart>>.seeded([]);

  List<MerchantCart> get _extraItems => items.value;

  CartStore(String savedValue) {
    if (savedValue != null && savedValue.isNotEmpty) {
      List<dynamic> body = json.decode(savedValue);
      List<MerchantCart> savedItems = [];
      body.forEach((dynamic item) {
        List<dynamic> cartData = item['merchantCartItems'];
        List<CartItemModel> savedCartItems = cartData.map((dynamic cartItem) => CartItemModel.fromJson(cartItem)).toList();
        savedItems.add(MerchantCart.fromJson({
          'merchant': MerchantModel.fromJson(item['merchant']),
          'merchantCartItems': savedCartItems,
        }));
      });
      items = BehaviorSubject<List<MerchantCart>>.seeded(savedItems);
    }
  }

  void addItem(CartItemModel newItem, MerchantModel merchant) async {
    var merchantIdx = _extraItems.indexWhere((element) => element.merchant.id == merchant.id);
    if (merchantIdx == -1) {
      var newMerchantCartItem = MerchantCart.fromJson({
        'merchant': merchant,
        'merchantCartItems': [newItem]
      });
      _extraItems.add(newMerchantCartItem);
      items.add(_extraItems);
    } else {
      var regIndex = _extraItems[merchantIdx].merchantCartItems.indexWhere((e) => e.id == newItem.id);
      if (regIndex == -1) {
        _extraItems[merchantIdx].merchantCartItems.add(newItem);
        items.add(_extraItems);
      } else {
        showToast('This item has been already added.');
      }
    }
    var value = await items.first;
    await _sharedPrefService.changeCartItems(json.encode(value));
  }

  void removeItem(int index, int merchantIdx) async {
    _extraItems[merchantIdx].merchantCartItems.removeAt(index);
    items.add(_extraItems);
    var value = await items.first;
    await _sharedPrefService.changeCartItems(json.encode(value));
  }

  void updateQuantity(int index, int quantity, int merchantIdx) async {
    _extraItems[merchantIdx].merchantCartItems[index].quantity = quantity;
    items.add(_extraItems);
    var value = await items.first;
    await _sharedPrefService.changeCartItems(json.encode(value));
  }

  void clearItems() async {
    items.add([]);
    await _sharedPrefService.changeCartItems(json.encode([]));
  }

  bool checkItemExist(String id) {
    int regIndex;
    for (var mCartItem in _extraItems) {
      regIndex = mCartItem.merchantCartItems.indexWhere((cartItem) => cartItem.id == id);
      if (regIndex != -1) {
        break;
      }
    }

    // item doesn't exist.
    if (regIndex == -1) {
      return false;
    } else {
      return true;
    }
  }

  void dispose() {
    items.close();
  }
}
