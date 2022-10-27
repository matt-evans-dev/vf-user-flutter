import 'package:rxdart/rxdart.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/services/networking/merchant/merchant_service.dart';

class FoodCollectionStore {
  final MerchantService _merchantSvc;
  BehaviorSubject<bool> isLoading;
  BehaviorSubject<List<ProductModel>> foods = BehaviorSubject<List<ProductModel>>.seeded([]);

  FoodCollectionStore(this._merchantSvc) {
    isLoading = BehaviorSubject<bool>.seeded(true);
  }

  void getFoodsByMerchant(String merchantId) async {
    isLoading.add(true);
    var result = await _merchantSvc.getProductsByMerchant(merchantId);
    foods.add(result);
    isLoading.add(false);
  }

  void dispose() {
    isLoading.close();
    foods.close();
  }
}
