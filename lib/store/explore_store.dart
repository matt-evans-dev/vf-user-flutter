import 'package:rxdart/rxdart.dart';
import 'package:vf_user_flutter_new/models/home/merchant_model.dart';
import 'package:vf_user_flutter_new/services/networking/merchant/merchant_service.dart';

class ExploreStore {
  final MerchantService _merchantSvc;
  BehaviorSubject<bool> isLoading;
  BehaviorSubject<List<MerchantModel>> merchants;

  ExploreStore(this._merchantSvc) {
    isLoading = BehaviorSubject<bool>.seeded(true);
    merchants = BehaviorSubject<List<MerchantModel>>.seeded([]);
  }

  Future<void> init() async {
    await getAllMerchants();
    // try {
    //
    // } finally {
    //   isLoading.add(false);
    // }
  }

  Future<void> searchMerchants(String query) async {
    isLoading.add(true);
    var value = await _merchantSvc.searchMerchant(query);
    merchants.add(value);
    isLoading.add(false);
  }

  Future<void> getAllMerchants() async {
    isLoading.add(true);
    var value = await _merchantSvc.getAllMerchants();
    merchants.add(value);
    isLoading.add(false);
  }

  void dispose() {
    isLoading.close();
    merchants.close();
  }
}
