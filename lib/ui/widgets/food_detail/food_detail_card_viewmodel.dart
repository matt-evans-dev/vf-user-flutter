import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/enum/bottom_tab_items.dart';
import 'package:vf_user_flutter_new/models/home/cart_item_model.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/store/cart_store.dart';
import 'package:vf_user_flutter_new/utils/funcs.dart';

import '../../../locator.dart';

class FoodDetailCardViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final _cartStore = locator<CartStore>();
  final ProductModel data;
  int quantity = 1;
  bool existInCart = false;

  FoodDetailCardViewModel({@required this.data}) {
    updateAddBtn();

    _cartStore.items.stream.listen((event) {
      updateAddBtn();
    });
  }

  void updateAddBtn() {
    existInCart = _cartStore.checkItemExist(data.id);
    notifyListeners();
  }

  void onIncrease(int limit) {
    if (quantity < limit) {
      quantity++;
      notifyListeners();
    } else {
      showToast('Out of stock');
    }
  }

  void onDecrease() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  void onAdd(ProductModel productInfo) {
    if (existInCart) {
      showCart();
    } else {
      CartItemModel item = CartItemModel(
        id: productInfo.id,
        productName: productInfo.name,
        quantity: quantity,
        productQuantity: productInfo.quantity,
        productPrice: productInfo.price,
        images: productInfo.image,
      );
      _cartStore.addItem(item, productInfo.merchant);
      showToast('Added to the cart.');

      // init quantity.
      quantity = 1;
    }
  }

  void showFoodDetailView() {
    _navSvc.navigateToFoodDetail(data);
  }

  void showCart() {
    _navSvc.popupToRoot();
    _navSvc.updateCurrentTab(BottomTabItem.cart);
  }
}
