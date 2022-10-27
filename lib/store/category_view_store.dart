import 'package:rxdart/rxdart.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/services/loggr.dart';
import 'package:vf_user_flutter_new/services/networking/merchant/merchant_service.dart';

class CategoryViewStore {
  final MerchantService _merchantSvc;
  BehaviorSubject<bool> isLoading;
  BehaviorSubject<List<ProductModel>> foods = BehaviorSubject<List<ProductModel>>.seeded([]);

  CategoryViewStore(this._merchantSvc) {
    isLoading = BehaviorSubject<bool>.seeded(true);
  }

  void getFoodsByCategory(String category) async {
    print('category before merchant service ===>>>> $category');
    isLoading.add(true);
    var result = await _merchantSvc.getAllProductsByCategory(category);
    logger.i(result);
    foods.add(result);
    isLoading.add(false);
  }

  void dispose() {
    isLoading.close();
    foods.close();
  }
}
