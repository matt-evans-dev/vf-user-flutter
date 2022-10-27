import 'package:get_it/get_it.dart';
import 'package:vf_user_flutter_new/services/location_service.dart';
import 'package:vf_user_flutter_new/services/loggr.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/services/networking/auth/auth_api.dart';
import 'package:vf_user_flutter_new/services/networking/auth/auth_service.dart';
import 'package:vf_user_flutter_new/services/networking/merchant/merchant_service.dart';
import 'package:vf_user_flutter_new/services/networking/order/order_api.dart';
import 'package:vf_user_flutter_new/services/networking/order/order_service.dart';
import 'package:vf_user_flutter_new/services/networking/payment/payment_api.dart';
import 'package:vf_user_flutter_new/services/networking/payment/payment_service.dart';
import 'package:vf_user_flutter_new/services/push_notification_service.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_service.dart';
import 'package:vf_user_flutter_new/store/auth_store.dart';
import 'package:vf_user_flutter_new/store/cart_store.dart';
import 'package:vf_user_flutter_new/store/category_view_store.dart';
import 'package:vf_user_flutter_new/store/explore_store.dart';
import 'package:vf_user_flutter_new/store/filter_store.dart';
import 'package:vf_user_flutter_new/store/food_collection_store.dart';
import 'package:vf_user_flutter_new/store/home_store.dart';
import 'package:vf_user_flutter_new/store/order_store.dart';
import 'package:vf_user_flutter_new/store/theme_store.dart';
import 'package:vf_user_flutter_new/ui/cart/cart/cart_viewmodel.dart';
import 'package:vf_user_flutter_new/ui/explore/explore_viewmodel.dart';
import 'package:vf_user_flutter_new/ui/home/category_view/category_view_viewmodel.dart';
import 'package:vf_user_flutter_new/ui/home/filter/filter_viewmodel.dart';
import 'package:vf_user_flutter_new/ui/home/home/home_viewmodel.dart';
import 'package:vf_user_flutter_new/ui/onboarding/forgot_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register navigation service.
  locator.registerSingleton<NavigationService>(NavigationService());

  // Register api and services.
  locator.registerLazySingleton<AuthApi>(() => AuthApi());
  locator.registerLazySingleton<OrderApi>(() => OrderApi());
  locator.registerLazySingleton<PaymentApi>(() => PaymentApi());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<OrderService>(() => OrderService());
  locator.registerLazySingleton<PaymentService>(() => PaymentService());

  // locator.registerLazySingleton<MerchantService>(() {
  //   UserLocationModel location = locator<LocationService>().currentLocation;
  //   return MerchantService(locator<LocationService>());
  // });

  locator.registerLazySingleton<MerchantService>(() => MerchantService(locator<LocationService>()));

  // Register shared preference service.
  locator.registerLazySingleton<SharedPreferenceService>(() => SharedPreferenceService());

  // Register some view models.
  locator.registerFactory<ForgotViewModel>(() => ForgotViewModel());
  locator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  locator.registerLazySingleton<ExploreViewModel>(() => ExploreViewModel());
  locator.registerLazySingleton<FilterViewModel>(() {
    var model = FilterViewModel();
    model.initValues();
    return model;
  });
  locator.registerLazySingleton<CartViewModel>(() => CartViewModel());
  locator.registerLazySingleton<CategoryViewModel>(() => CategoryViewModel());

  // Register stores.
  locator.registerSingletonAsync<ThemeStore>(() async {
    var sharedPrefService = locator<SharedPreferenceService>();
    var savedTheme = await sharedPrefService.isDarkMode;
    return ThemeStore(savedTheme);
  });

  locator.registerSingletonAsync<AuthStore>(() async {
    var sharedPrefService = locator<SharedPreferenceService>();
    var isLoggedIn = await sharedPrefService.isLoggedIn;
    return AuthStore(isLoggedIn);
  });

  locator.registerLazySingleton<HomeStore>(() {
    var store = HomeStore(locator<MerchantService>());
    store.init();
    return store;
  });

  locator.registerLazySingleton<ExploreStore>(() {
    var store = ExploreStore(locator<MerchantService>());
    store.init();
    return store;
  });

  locator.registerSingletonAsync<OrderStore>(() async {
    var sharedPrefService = locator<SharedPreferenceService>();
    var isLoggedIn = await sharedPrefService.isLoggedIn;
    return OrderStore();
  });

  locator.registerSingleton<FilterStore>(FilterStore());

  locator.registerSingletonAsync<CartStore>(() async {
    var sharedPrefService = locator<SharedPreferenceService>();
    var cartItems = await sharedPrefService.cartItems;
    logger.i(cartItems);
    return CartStore(cartItems);
  });

  locator.registerLazySingleton<FoodCollectionStore>(() => FoodCollectionStore(locator<MerchantService>()));

  locator.registerLazySingleton<CategoryViewStore>(() => CategoryViewStore(locator<MerchantService>()));

  // Register location service
  locator.registerSingletonAsync<LocationService>(
    () async {
      var _locationSvc = LocationService(locator<SharedPreferenceService>());
      await _locationSvc.init();
      return _locationSvc;
    },
  );

  // Register push notification service
  locator.registerLazySingleton(() => PushNotificationService());
}
