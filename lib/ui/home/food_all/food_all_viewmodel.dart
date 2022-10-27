import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/store/home_store.dart';

class FoodAllViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final _homeStore = locator<HomeStore>();

  List<ProductModel> products = [];

  FoodAllViewModel() {
    // _homeStore.allProducts.stream.listen((value) {
    //   productsUpdated(value);
    // });
  }

  void showFoodCollectionView() {}

  void productsUpdated(List<ProductModel> value) {
    products = value;
    notifyListeners();
  }
}
