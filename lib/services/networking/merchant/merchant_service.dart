import 'dart:convert';

import 'package:vf_user_flutter_new/constants/strings.dart';
import 'package:vf_user_flutter_new/models/home/merchant_model.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/services/loggr.dart';
import 'package:vf_user_flutter_new/services/networking/api_base_helper.dart';
import 'package:vf_user_flutter_new/store/filter_store.dart';

import '../../../locator.dart';
import '../../location_service.dart';

class MerchantService {
  final ApiBaseHelper _api = ApiBaseHelper();
  final FilterStore _filterStore = locator<FilterStore>();
  final LocationService _locationSvc;

  MerchantService(this._locationSvc);

  Future<List<ProductModel>> getAllProducts() async {
    // Setup filter options from filter store.
    List<String> filterCategories = [];
    // logger.i(_filterStore.kitchenIndex);
    if (_filterStore.kitchenIndex != null) filterCategories.add(AppStrings.flCountries[_filterStore.kitchenIndex]);
    if (_filterStore.foodIndex != null) filterCategories.add(AppStrings.flFoods[_filterStore.foodIndex]);
    if (_filterStore.dietaryIndex != null) filterCategories.add(AppStrings.flDietaries[_filterStore.dietaryIndex]);

    // logger.i(filterCategories);

    int rating = 0;
    if (_filterStore.ratingIndex != null) rating = _filterStore.ratingIndex;
    // logger.i(rating);
    double minPrice = _filterStore.minPrice;
    double maxPrice = _filterStore.minPrice;

    final responseJson = await _api.post(
      'product/data',
      jsonEncode(<String, dynamic>{
        "status": "available",
        "location": {
          "longitude": _locationSvc.currentLocation.longitude,
          "latitude": _locationSvc.currentLocation.latitude,
          "maxDistance": 5000,
        },
        "type": "user",
        if (filterCategories.length > 0) "category": {"\$in": filterCategories} else "category": "",
        if (minPrice == 0 && maxPrice == 0) "price": "" else "price": {"minPrice": minPrice, "maxPrice": maxPrice},
        if (rating == 0) "rating": "" else "rating": rating,
      }),
    );

    var allProducts = List.from(responseJson['products'])
        .map(
          (item) => ProductModel.fromJson(item),
        )
        .toList();
    return allProducts;
  }

  // Search products with category
  Future<List<ProductModel>> getAllProductsByCategory(String category) async {
    print('category  $category');
    List<String> filterCategories = [];
    filterCategories.add(category);

    final responseJson = await _api.post(
      'product/data',
      jsonEncode(<String, dynamic>{
        "status": "available",
        "location": {
          "longitude": _locationSvc.currentLocation.longitude,
          "latitude": _locationSvc.currentLocation.latitude,
          "maxDistance": 5000,
        },
        "type": "user",
        "category": {"\$in": filterCategories},
        "price": "",
        "rating": "",
      }),
    );

    var allProducts = List.from(responseJson['products'])
        .map(
          (item) => ProductModel.fromJson(item),
        )
        .toList();
    return allProducts;
  }

  // Search products with query.
  Future<List<ProductModel>> searchProducts(String query) async {
    final responseJson = await _api.post(
      'merchant/search',
      jsonEncode(<String, dynamic>{
        "merchantName": "",
        "productName": query,
        "location": {
          "longitude": _locationSvc.currentLocation.longitude,
          "latitude": _locationSvc.currentLocation.latitude,
          "maxDistance": 5000,
        }
      }),
    );

    List<ProductModel> resultProducts = List.from(responseJson['products']).map(
      (item) {
        // logger.i(item);
        return ProductModel.fromJson(item);
      },
    ).toList();

    return resultProducts;
  }

  // Search merchants with query.
  Future<List<MerchantModel>> searchMerchant(String query) async {
    final responseJson = await _api.post(
      'merchant/search',
      jsonEncode(<String, dynamic>{
        "merchantName": query,
        "productName": "",
        "location": {
          "longitude": _locationSvc.currentLocation.longitude,
          "latitude": _locationSvc.currentLocation.latitude,
          "maxDistance": 5000,
        }
      }),
    );

    // logger.i(responseJson);

    List<MerchantModel> merchants = List.from(responseJson['merchants'])
        .map(
          (merchantJson) => MerchantModel.fromJson(merchantJson),
        )
        .toList();
    return merchants;
  }

  // Search all merchants.
  Future<List<MerchantModel>> getAllMerchants() async {
    final responseJson = await _api.post(
      'merchant/filter',
      jsonEncode(<String, dynamic>{
        "location": {
          "longitude": _locationSvc.currentLocation.longitude,
          "latitude": _locationSvc.currentLocation.latitude,
          "maxDistance": 5000,
        },
        "status": "active"
      }),
    );

    // logger.i(responseJson);

    List<MerchantModel> merchants = List.from(responseJson['merchants'])
        .map(
          (merchantJson) => MerchantModel.fromJson(merchantJson),
        )
        .toList();
    return merchants;
  }

  // Search products by merchant
  Future<List<ProductModel>> getProductsByMerchant(String merchantId) async {
    final responseJson = await _api.post(
      'product/data',
      jsonEncode(<String, dynamic>{
        "status": "available",
        "location": {
          "longitude": _locationSvc.currentLocation.longitude,
          "latitude": _locationSvc.currentLocation.latitude,
          "maxDistance": 5000,
        },
        "merchant": merchantId,
        "type": "user"
      }),
    );

    List<ProductModel> resultProducts = List.from(responseJson['products']).map(
      (item) {
        logger.i(item);
        return ProductModel.fromJson(item);
      },
    ).toList();
    return resultProducts;
  }
}
