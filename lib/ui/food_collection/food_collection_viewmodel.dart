import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/store/food_collection_store.dart';

class FoodCollectionViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final _collectionStore = locator<FoodCollectionStore>();

  bool isLoading = true;
  List<ProductModel> foods = [];

  FoodCollectionViewModel() {
    _collectionStore.isLoading.stream.listen((event) {
      isLoading = event;
      notifyListeners();
    });

    _collectionStore.foods.stream.listen((event) {
      foods = event;
    });
  }

  void showAddTo(ProductModel productInfo) {}
}
