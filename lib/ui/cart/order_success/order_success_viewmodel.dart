import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/enum/bottom_tab_items.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';

class OrderSuccessViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();

  void shoBrowsingFood() {
    // _navSvc.popupToSpecRootView(AppRoutes.confirmOrderRoute);
    _navSvc.appNavigatorKey.currentState.pop();
    _navSvc.appNavigatorKey.currentState.pop();
    _navSvc.updateCurrentTab(BottomTabItem.home);
  }
}
