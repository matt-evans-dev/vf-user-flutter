import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';

class OnboardingNavigator extends HookWidget {
  final String initialRoute;
  OnboardingNavigator(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    // final navSvc = locator<NavigationService>();
    final onboardingNavKey = locator<NavigationService>().onboardingNavigatorKey;

    return Navigator(
      key: onboardingNavKey,
      initialRoute: initialRoute,
      onGenerateRoute: AppRoutes.onboardingGenerateRoutes,
    );
  }
}

class OnboardingNavArgs {
  final String initialRoute;
  OnboardingNavArgs(this.initialRoute);
}
