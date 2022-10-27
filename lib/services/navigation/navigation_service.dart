import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vf_user_flutter_new/constants/enum/bottom_tab_items.dart';
import 'package:vf_user_flutter_new/models/home/merchant_model.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/ui/food_collection/food_collection_view.dart';
import 'package:vf_user_flutter_new/ui/food_detail/food_detail_view.dart';
import 'package:vf_user_flutter_new/ui/location/location_view.dart';

class NavigationService {
  // Whole app navigator key.
  final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();
  // All bottom navigator keys.
  final Map<BottomTabItem, GlobalKey<NavigatorState>> tabNavigatorKeys = {
    BottomTabItem.home: GlobalKey<NavigatorState>(),
    BottomTabItem.explore: GlobalKey<NavigatorState>(),
    BottomTabItem.cart: GlobalKey<NavigatorState>(),
    BottomTabItem.account: GlobalKey<NavigatorState>(),
    BottomTabItem.orders: GlobalKey<NavigatorState>(),
  };
  // Onboarding navigator
  final GlobalKey<NavigatorState> onboardingNavigatorKey = GlobalKey<NavigatorState>();

  // Current selected tab.
  BehaviorSubject<BottomTabItem> currentTab = BehaviorSubject<BottomTabItem>.seeded(BottomTabItem.home);
  // Get current selected tab.
  BottomTabItem get getCurrentTab => currentTab.value;
  // Update current tab.
  void updateCurrentTab(BottomTabItem selTabItem) {
    currentTab.add(selTabItem);
  }

  // Navigate to root screen
  Future<dynamic> navigateToRootView(String routeName, {dynamic arg}) {
    return appNavigatorKey.currentState.pushNamed(routeName, arguments: arg);
  }

  // Get current selected tab navigator key.
  // If you define tabItem, then the specific tab navigator will be returned.
  GlobalKey<NavigatorState> getTabNavigatorKey({BottomTabItem tabItem}) {
    return tabNavigatorKeys[tabItem ?? currentTab.value];
  }

  // Navigate to the specific route in the SAME tab navigator.
  // If you define tabItem, then it will navigate to the specific route in the DIFFERENT tab navigator.
  Future<dynamic> navigateTo(String routeName, {BottomTabItem tabItem, dynamic arguments}) {
    var selTabNavigator = getTabNavigatorKey(tabItem: tabItem ?? currentTab.value);
    return selTabNavigator.currentState.pushNamed(routeName, arguments: arguments);
  }

  // Pop to first route in the tab stack
  // If you define tabItem, then it will pop to the first route of other tab stack.
  void popupToRoot({BottomTabItem tabItem}) {
    var selTabNavigator = getTabNavigatorKey(tabItem: tabItem ?? currentTab.value);
    selTabNavigator.currentState.popUntil((route) => route.isFirst);
  }

  /// TODO make this function
  // Pop to the specific root views.
  void popupToSpecRootView(String routeName, {BottomTabItem tabItem}) {}

  // Pop one route in the current bottom navigator:
  void popup() {
    getTabNavigatorKey().currentState.pop();
  }

  // Generate new FoodCollectionView
  void navigateToFoodCollection(MerchantModel data) {
    getTabNavigatorKey().currentState.push(_buildRoute((_) {
      return FoodCollectionView(
        merchantData: data,
      );
    }));
  }

  // Generate new FoodDetailView
  void navigateToFoodDetail(ProductModel data) {
    getTabNavigatorKey().currentState.push(_buildRoute((_) {
      return FoodDetailView(
        data: data,
      );
    }));
  }

  // Generate new LocationView
  void navigateToLocation() {
    getTabNavigatorKey().currentState.push(_buildRoute((_) {
      return LocationView();
    }));
  }

  MaterialPageRoute _buildRoute(WidgetBuilder builder) {
    return MaterialPageRoute(builder: builder, maintainState: false);
  }

  void dispose() {
    currentTab.close();
  }

  // BehaviorSubject<BottomTabItem> currentTab = BehaviorSubject<BottomTabItem>.seeded(BottomTabItem.home);
  // RxValue<BottomTabItem> _currentTab = RxValue<BottomTabItem>(initial: BottomTabItem.home);
  // BottomTabItem get currentTab => _currentTab.value;
  // set currentTab(BottomTabItem selTabItem) {
  //   _currentTab.value = selTabItem;
  // }
}
