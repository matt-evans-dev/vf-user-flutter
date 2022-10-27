import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/enum/bottom_tab_items.dart';
import 'package:vf_user_flutter_new/ui/account/account_view.dart';
import 'package:vf_user_flutter_new/ui/account/manage_account_view.dart';
import 'package:vf_user_flutter_new/ui/account/manage_payment_view.dart';
import 'package:vf_user_flutter_new/ui/cart/add_card/add_card_view.dart';
import 'package:vf_user_flutter_new/ui/cart/add_payment_view/add_payment_method_view.dart';
import 'package:vf_user_flutter_new/ui/cart/cart/cart_view.dart';
import 'package:vf_user_flutter_new/ui/cart/confirm_order/confirm_oder_view.dart';
import 'package:vf_user_flutter_new/ui/cart/order_success/order_success_view.dart';
import 'package:vf_user_flutter_new/ui/explore/explore_view.dart';
import 'package:vf_user_flutter_new/ui/home/category_view/category_view.dart';
import 'package:vf_user_flutter_new/ui/home/filter/filter_view.dart';
import 'package:vf_user_flutter_new/ui/home/food_all/food_all_view.dart';
import 'package:vf_user_flutter_new/ui/home/home/home_view.dart';
import 'package:vf_user_flutter_new/ui/onboarding/forgot_view.dart';
import 'package:vf_user_flutter_new/ui/onboarding/login_view.dart';
import 'package:vf_user_flutter_new/ui/onboarding/new_password_view.dart';
import 'package:vf_user_flutter_new/ui/onboarding/signup_view.dart';
import 'package:vf_user_flutter_new/ui/onboarding/splash_view.dart';
import 'package:vf_user_flutter_new/ui/onboarding/verification_code_view.dart';
import 'package:vf_user_flutter_new/ui/orders/orders_view.dart';
import 'package:vf_user_flutter_new/ui/root_view.dart';

import '../ui/location/location_view.dart';
import 'onboarding_navigator.dart';

class AppRoutes {
  AppRoutes._();

  // Define route name:
  static const root = '/';
  static const appRoot = '/appRoot';
  static const filterRoute = '/filterRoute';
  static const foodAllRoute = '/foodAllRoute';
  static const categoryViewRoute = '/categoryViewRoute';
  static const locationRoute = '/locationRoute';

  static const confirmOrderRoute = '/confirmOrderRoute';
  static const addPaymentRoute = '/addPaymentRoute';
  static const addCardRoute = '/addCardRoute';
  static const orderSuccessRoute = '/orderSuccessRoute';

  static const onboardingRoute = '/onboardingRoute';
  static const splashRoute = '/splashRoute';
  static const loginRoute = '/loginRoute';
  static const signUpRoute = '/signUpRoute';
  static const forgotRoute = '/forgotRoute';
  static const verificationCodeRoute = '/verificationCodeRoute';
  static const newPwdRoute = '/newPwdRoute';
  static const manageAccountRoute = '/manageAccountRoute';
  static const managePaymentRoute = '/managePaymentRoute';

  static Route<dynamic> mainGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // App root route:
      case locationRoute:
        return MaterialPageRoute(builder: (_) => LocationView(isFirstLaunch: true));
      case appRoot:
        return MaterialPageRoute(builder: (_) => RootView());
      case onboardingRoute:
        OnboardingNavArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => OnboardingNavigator(args.initialRoute));
      case filterRoute:
        return MaterialPageRoute(builder: (_) => FilterView());
      case confirmOrderRoute:
        return MaterialPageRoute(builder: (_) => ConfirmOrderView());
      case addPaymentRoute:
        return MaterialPageRoute(builder: (_) => AddPaymentView());
      case addCardRoute:
        return MaterialPageRoute(builder: (_) => AddCardView());
      case orderSuccessRoute:
        return MaterialPageRoute(builder: (_) => OrderSuccessView());
      default:
        return errorRoute(settings);
    }
  }

  static Route<dynamic> onboardingGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // Onboarding root route:
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case forgotRoute:
        return MaterialPageRoute(builder: (_) => ForgotView());
      case verificationCodeRoute:
        return MaterialPageRoute(builder: (_) => VerificationCodeView());
      case newPwdRoute:
        return MaterialPageRoute(builder: (_) => NewPasswordView());
      case manageAccountRoute:
        return MaterialPageRoute(builder: (_) => ManageAccountView());
      case managePaymentRoute:
        return MaterialPageRoute(builder: (_) => ManagePaymentView());
      default:
        return errorRoute(settings);
    }
  }

  // Define bottom generate routes.
  static Map<BottomTabItem, Function(RouteSettings)> bottomGenerateRoutes = {
    BottomTabItem.home: homeGenerateRoutes,
    BottomTabItem.explore: exploreGenerateRoutes,
    BottomTabItem.cart: cartGenerateRoutes,
    BottomTabItem.orders: ordersGenerateRoutes,
    BottomTabItem.account: accountGenerateRoutes,
  };

  // Home routes:
  static Route<dynamic> homeGenerateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // Root route:
      case root:
        return MaterialPageRoute(builder: (_) => HomeView());
      case foodAllRoute:
        return MaterialPageRoute(builder: (_) => FoodAllView());
      case categoryViewRoute:
        return MaterialPageRoute(builder: (_) => CategoryView(data: args));
      default:
        return errorRoute(settings);
    }
  }

  // Explore Routes:
  static Route<dynamic> exploreGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // Root route:
      case root:
        return MaterialPageRoute(builder: (_) => ExploreView());
      default:
        return errorRoute(settings);
    }
  }

  // Cart Routes:
  static Route<dynamic> cartGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // Root route:
      case root:
        return MaterialPageRoute(builder: (_) => CartView());
      default:
        return errorRoute(settings);
    }
  }

  // Order Routes:
  static Route<dynamic> ordersGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // Root route:
      case root:
        return MaterialPageRoute(builder: (_) => OrdersView());
      default:
        return errorRoute(settings);
    }
  }

  // Account Routes:
  static Route<dynamic> accountGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // Root route:
      case root:
        return MaterialPageRoute(builder: (_) => AccountView());
      default:
        return errorRoute(settings);
    }
  }

  // Error route
  static Route<dynamic> errorRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => _ErrorView(name: settings.name));
  }
}

class _ErrorView extends StatelessWidget {
  final String name;
  _ErrorView({@required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('No route defined for $name')),
    );
  }
}
