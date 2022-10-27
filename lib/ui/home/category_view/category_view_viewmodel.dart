import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';
import 'package:vf_user_flutter_new/store/category_view_store.dart';

class CategoryViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final _categoryViewStore = locator<CategoryViewStore>();

  bool isLoading = true;
  List<ProductModel> foods = [];

  CategoryViewModel() {
    _categoryViewStore.isLoading.stream.listen((event) {
      print('event ===>>> $event');
      isLoading = event;
      notifyListeners();
    });

    _categoryViewStore.foods.stream.listen((event) {
      foods = event;
    });
  }

  void showAddTo(ProductModel productInfo) {}
}
