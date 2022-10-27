import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/home/merchant_model.dart';
import 'package:vf_user_flutter_new/models/user/user_location_mdel.dart';
import 'package:vf_user_flutter_new/services/location_service.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/store/explore_store.dart';
import 'package:vf_user_flutter_new/store/food_collection_store.dart';

class ExploreViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final _exploreStore = locator<ExploreStore>();
  final _collectionStore = locator<FoodCollectionStore>();
  final TextEditingController searchFieldController = TextEditingController();

  UserLocationModel currentLocation = locator<LocationService>().currentLocation;
  bool isLoading = true;
  List<MerchantModel> merchants = [];
  String query = '';

  ExploreViewModel() {
    locator<LocationService>().curLocationStream.listen((value) {
      locationUpdated(value);
    });

    _exploreStore.isLoading.stream.listen((value) {
      onLoad(value);
    });

    _exploreStore.merchants.stream.listen((value) {
      merchantsUpdated(value);
    });
  }

  void searchMerchants(String query) async {
    _exploreStore.searchMerchants(query);
  }

  // Choose custom location.
  void showLocationPickerView(BuildContext context) async {
    _navSvc.navigateToLocation();
  }

  // Listen location stream.
  void locationUpdated(UserLocationModel value) async {
    currentLocation = value;
    await _exploreStore.getAllMerchants();
  }

  // Listen merchants stream.
  void merchantsUpdated(List<MerchantModel> value) {
    merchants = value;
  }

  // Listen loading stream.
  void onLoad(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Navigate to the FoodCollectionView.
  void showFoodCollectionView(MerchantModel data) {
    _collectionStore.getFoodsByMerchant(data.id);
    _navSvc.navigateToFoodCollection(data);
    // _navSvc.updateCurrentTab(BottomTabItem.home);
    // _navSvc.navigateTo(AppRoutes.foodCollectionRoute, arguments: data);
  }
}
