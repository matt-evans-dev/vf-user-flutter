import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/enum/bottom_tab_items.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';

class AppValues {
  AppValues._();

  // Define some constants.
  static const Map<BottomTabItem, dynamic> bottomTabItems = {
    BottomTabItem.home: _BottomTabItemInfo(AppStrings.homeBtm, Icons.home_outlined),
    BottomTabItem.explore: _BottomTabItemInfo(AppStrings.nearBtm, Icons.explore_outlined),
    BottomTabItem.cart: _BottomTabItemInfo(AppStrings.cartBtm, Icons.shopping_cart_outlined),
    BottomTabItem.orders: _BottomTabItemInfo(AppStrings.orderBtm, Icons.shopping_bag_outlined),
    BottomTabItem.account: _BottomTabItemInfo(AppStrings.accountBtm, Icons.account_circle_outlined),
  };

  static const List<String> ratingIcons = [
    AppAssets.bronzeMedalIcon,
    AppAssets.silverMedalIcon,
    AppAssets.goldMedalIcon,
  ];

  static const List<CategoryInfo> categories = [
    CategoryInfo('Pizza', AppAssets.pizzaImg),
    CategoryInfo('Seafood', AppAssets.seafoodImg),
    CategoryInfo('Meat', AppAssets.meatImg),
    CategoryInfo('Breakfast', AppAssets.breakfastImg),
    CategoryInfo('Soups', AppAssets.soupsImg),
    CategoryInfo('Salads', AppAssets.saladImg),
    CategoryInfo('Dessert', AppAssets.dessertImg),
  ];

  static const CameraPosition googlePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
}

class _BottomTabItemInfo {
  final String label;
  final IconData iconData;
  const _BottomTabItemInfo(this.label, this.iconData);
}

class CategoryInfo {
  final String name;
  final String img;
  const CategoryInfo(this.name, this.img);
}
