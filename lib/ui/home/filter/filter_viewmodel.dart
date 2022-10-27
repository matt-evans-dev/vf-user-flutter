import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/enum/filter_option.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/store/filter_store.dart';
import 'package:vf_user_flutter_new/store/home_store.dart';
import '../../../locator.dart';

class FilterViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final _filterStore = locator<FilterStore>();
  final _homeStore = locator<HomeStore>();

  int kitchenIndex;
  int foodIndex;
  int dietaryIndex;
  int rating;
  double lowerValue;
  double upperValue;

  void updateIndex(FilterOptions flOption, bool value, int index) {
    switch (flOption) {
      case FilterOptions.KITCHEN:
        kitchenIndex = value ? index : null;
        break;
      case FilterOptions.FOOD:
        foodIndex = value ? index : null;
        break;
      case FilterOptions.DIETARY:
        dietaryIndex = value ? index : null;
        break;
      default:
        return;
    }
    notifyListeners();
  }

  void initValues() {
    kitchenIndex = locator<FilterStore>().kitchenIndex;
    foodIndex = locator<FilterStore>().foodIndex;
    dietaryIndex = locator<FilterStore>().dietaryIndex;
    rating = locator<FilterStore>().ratingIndex;
    lowerValue = locator<FilterStore>().minPrice ?? 0;
    upperValue = locator<FilterStore>().minPrice ?? 0;
  }

  void updateRangeValue(double lowerValue, double upperValue) {
    this.lowerValue = lowerValue;
    _filterStore.minPriceQuery.add(lowerValue);
    this.upperValue = upperValue;
    _filterStore.maxPriceQuery.add(lowerValue);
    notifyListeners();
  }

  void updateRating(int index) {
    rating = index;
    _filterStore.ratingQueryIndex.add(index);
    notifyListeners();
  }

  void onApply() {
    _filterStore.kitchenQueryIndex.add(kitchenIndex);
    _filterStore.foodQueryIndex.add(foodIndex);
    _filterStore.dietaryQueryIndex.add(dietaryIndex);
    _homeStore.getAllProducts();
    _navSvc.appNavigatorKey.currentState.pop();
  }

  void onClean() {
    kitchenIndex = null;
    foodIndex = null;
    dietaryIndex = null;
    rating = null;
    lowerValue = 0;
    upperValue = 0;
    _filterStore.init();
    notifyListeners();
  }

  bool hasFilterOptions() {
    return kitchenIndex != null || foodIndex != null || dietaryIndex != null || rating != null || lowerValue > 0 || upperValue > 0;
  }
}
