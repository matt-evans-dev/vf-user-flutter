import 'package:rxdart/rxdart.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/models/home/merchant_model.dart';
import 'package:vf_user_flutter_new/services/networking/merchant/merchant_service.dart';

class HomeStore {
  final MerchantService _merchantSvc;
  BehaviorSubject<bool> isLoading;
  BehaviorSubject<List<ProductModel>> allProducts;
  BehaviorSubject<List<ProductModel>> productResults;
  BehaviorSubject<List<MerchantModel>> restaurantResults;

  HomeStore(this._merchantSvc) {
    isLoading = BehaviorSubject<bool>.seeded(true);
    allProducts = BehaviorSubject<List<ProductModel>>.seeded([]);
    productResults = BehaviorSubject<List<ProductModel>>.seeded([]);
    restaurantResults = BehaviorSubject<List<MerchantModel>>.seeded([]);
  }

  Future<void> init() async {
    // await getAllProducts();
    isLoading.add(false);
  }

  Future<void> getAllProducts() async {
    isLoading.add(true);
    var value = await _merchantSvc.getAllProducts();
    allProducts.add(value);
    isLoading.add(false);
  }

  void dispose() {
    isLoading.close();
    allProducts.close();
    productResults.close();
    restaurantResults.close();
  }

  Future<void> searchFoods(String query) async {
    isLoading.add(true);
    var value = await _merchantSvc.searchProducts(query);
    productResults.add(value);
    isLoading.add(false);
  }

  Future<void> searchRestaurants(String query) async {
    isLoading.add(true);
    var value = await _merchantSvc.searchMerchant(query);
    restaurantResults.add(value);
    isLoading.add(false);
  }
}
