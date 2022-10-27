import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/bottom_tab_items.dart';
import 'package:vf_user_flutter_new/constants/font_family.dart';
import 'package:vf_user_flutter_new/constants/vals.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';

class BottomNavigator extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navSvc = locator<NavigationService>();
    Map<BottomTabItem, GlobalKey<NavigatorState>> navKeys = navSvc.tabNavigatorKeys;
    BottomTabItem currentTab = useStream(navSvc.currentTab, initialData: BottomTabItem.home).data;
    // print('re render ===>>>> ${currentTab.index}');

    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await navSvc.getTabNavigatorKey().currentState.maybePop();
        print(isFirstRouteInCurrentTab);
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (currentTab != BottomTabItem.home) {
            // select 'main' tab
            navSvc.updateCurrentTab(BottomTabItem.home);
            // // back button handled by app
            // return false;
          }
          // back button handled by app
          return false;
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          // Hide all tab screens except for focused tab screen by using Offstage widget
          children: [
            _buildOffstageNavigator(navKeys[BottomTabItem.home], BottomTabItem.home, currentTab),
            _buildOffstageNavigator(navKeys[BottomTabItem.explore], BottomTabItem.explore, currentTab),
            _buildOffstageNavigator(navKeys[BottomTabItem.cart], BottomTabItem.cart, currentTab),
            _buildOffstageNavigator(navKeys[BottomTabItem.orders], BottomTabItem.orders, currentTab),
            _buildOffstageNavigator(navKeys[BottomTabItem.account], BottomTabItem.account, currentTab),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          unselectedFontSize: AppDimens.fontM,
          selectedFontSize: AppDimens.fontM,
          selectedLabelStyle: TextStyle(
            fontFamily: AppFontFamily.montserrat,
            fontWeight: FontWeight.w700,
          ),
          // unselectedLabelStyle: ,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).accentColor,
          // Be careful of tab index.
          currentIndex: currentTab.index,
          items: [
            _buildItem(BottomTabItem.home),
            _buildItem(BottomTabItem.explore),
            _buildItem(BottomTabItem.cart),
            _buildItem(BottomTabItem.orders),
            _buildItem(BottomTabItem.account),
          ],
          onTap: (index) {
            BottomTabItem selCurrTabItem = BottomTabItem.values[index];
            if (selCurrTabItem == currentTab) {
              // Pop to the first route in the current route stack.
              navKeys[currentTab].currentState.popUntil((route) => route.isFirst);
            } else {
              // Update the current tab
              navSvc.updateCurrentTab(selCurrTabItem);
            }
          },
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(GlobalKey<NavigatorState> navKey, BottomTabItem defaultTabItem, BottomTabItem currentTab) {
    return Offstage(
      offstage: defaultTabItem != currentTab,
      child: Navigator(
        key: navKey,
        initialRoute: AppRoutes.root,
        onGenerateRoute: AppRoutes.bottomGenerateRoutes[defaultTabItem],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(BottomTabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(AppValues.bottomTabItems[tabItem].iconData),
      label: AppValues.bottomTabItems[tabItem].label,
    );
  }
}
