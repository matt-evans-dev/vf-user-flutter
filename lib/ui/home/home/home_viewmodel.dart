import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/enum/search_filter.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';
import 'package:vf_user_flutter_new/constants/vals.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/home/merchant_model.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/models/user/user_location_mdel.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/location_service.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/services/push_notification_service.dart';
import 'package:vf_user_flutter_new/store/category_view_store.dart';
import 'package:vf_user_flutter_new/store/filter_store.dart';
import 'package:vf_user_flutter_new/store/food_collection_store.dart';
import 'package:vf_user_flutter_new/store/home_store.dart';
import 'package:vf_user_flutter_new/ui/home/filter/filter_viewmodel.dart';
import 'package:vf_user_flutter_new/ui/widgets/home/search_filter_dialog.dart';

class HomeViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final _homeStore = locator<HomeStore>();
  final _filterStore = locator<FilterStore>();
  final _collectionStore = locator<FoodCollectionStore>();
  final _filterViewModel = locator<FilterViewModel>();
  final _categoryViewStore = locator<CategoryViewStore>();

  UserLocationModel currentLocation = locator<LocationService>().currentLocation;
  bool isLoading = true;
  List<ProductModel> allProducts = [];
  String kitchenQuery = AppStrings.flAll;
  SearchFilter searchFilter;
  String searchQuery = '';
  List<ProductModel> productResults = [];
  List<MerchantModel> restaurantResults = [];

  HomeViewModel() {
    // The logic according to the change of the location.
    locator<LocationService>().curLocationStream.listen((value) {
      locationUpdated(value);
    });

    // Update the status of loading.
    _homeStore.isLoading.stream.listen((value) {
      onLoad(value);
    });

    // Update all foods by search query.
    _homeStore.allProducts.stream.listen((value) {
      allProducts = value;
    });

    // Update foods by search query.
    _homeStore.productResults.stream.listen((value) {
      productResults = value;
    });

    // Update the restaurants by search query.
    _homeStore.restaurantResults.stream.listen((value) {
      restaurantResults = value;
    });

    // Sync the filter option with FilterView.
    _filterStore.kitchenStream.listen((value) {
      kitchenQuery = value == null ? AppStrings.flAll : AppStrings.flCountries[value];
    });

    initFCM();
  }

  void initFCM() {
    final PushNotificationService _pushNotificationService = locator<PushNotificationService>();
    _pushNotificationService.initialise();
  }

  void showFilterView() {
    _filterViewModel.initValues();
    _navSvc.navigateToRootView(AppRoutes.filterRoute);
  }

  void showFoodCollectionView(MerchantModel data) {
    _collectionStore.getFoodsByMerchant(data.id);
    _navSvc.navigateToFoodCollection(data);
  }

  void showCategoryView(CategoryInfo category) {
    _categoryViewStore.getFoodsByCategory(category.name);
    _navSvc.navigateTo(AppRoutes.categoryViewRoute, arguments: category);
  }

  void showFoodAllView() {
    _navSvc.navigateTo(AppRoutes.foodAllRoute);
  }

  void showLocationPickerView(BuildContext context) async {
    _navSvc.navigateToLocation();
    // LocationResult result = await showLocationPicker(
    //   context,
    //   AppValues.GOOGLE_MAP_API_KEY,
    //   myLocationButtonEnabled: true,
    //   layersButtonEnabled: true,
    // );
    //
    // var updatedLocation = UserLocationModel(
    //   location: result.address,
    //   latitude: result.latLng.latitude,
    //   longitude: result.latLng.longitude,
    // );
    //
    // // Update location service and local storage.
    // _locationSvc.updateCurrentLocation(updatedLocation);
    // _merchantSvc.setCoordinate(updatedLocation);
    // await _homeStore.getAllProducts();
  }

  void locationUpdated(UserLocationModel value) async {
    currentLocation = value;
    // await _homeStore.getAllProducts();
  }

  void onLoad(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void changeCountryQuery(String value) {
    kitchenQuery = value;
    int index = AppStrings.flCountries.indexWhere((e) => e == value);
    _filterStore.kitchenQueryIndex.add(index == -1 ? null : index);
    _homeStore.getAllProducts();
    notifyListeners();
  }

  void changeSearchQuery(String value) {
    // searchQuery = value;
    notifyListeners();
  }

  void onShowFilterDialog(String value) {
    // Update search query.
    searchQuery = value;

    // Show filter dialog.
    var currentTabKey = _navSvc.getTabNavigatorKey();
    showDialog<void>(
      context: currentTabKey.currentState.overlay.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SearchFilterDialog(
          onSearch: onSearch,
        );
      },
    );
  }

  void onSearch(SearchFilter value) {
    searchFilter = value;
    if (value == SearchFilter.Foods) {
      _homeStore.searchFoods(searchQuery);
    } else if (value == SearchFilter.Restaurants) {
      _homeStore.searchRestaurants(searchQuery);
    }
  }
}
