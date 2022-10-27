import 'package:vf_user_flutter_new/services/networking/api_base_helper.dart';

class PaymentApi {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<dynamic> getCards(dynamic body) async {
    return _apiBaseHelper.post('user/cards', body);
  }
}
