import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vf_user_flutter_new/constants/app_theme.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/store/theme_store.dart';

import '../locator.dart';
import 'app_routes.dart';

class AppNavigator extends HookWidget {
  final String savedLocation;
  AppNavigator(this.savedLocation);

  @override
  Widget build(BuildContext context) {
    final _navSvc = locator<NavigationService>();
    var isDarkTheme = useStream(locator<ThemeStore>().isDarkTheme, initialData: false).data;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: isDarkTheme ? darkThemeData : themeData,
      navigatorKey: _navSvc.appNavigatorKey,
      onGenerateRoute: AppRoutes.mainGenerateRoutes,
      initialRoute: savedLocation == null ? AppRoutes.locationRoute : AppRoutes.appRoot,
    );
  }
}
