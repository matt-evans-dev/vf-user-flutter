import 'package:json_annotation/json_annotation.dart';
import 'package:vf_user_flutter_new/models/home/location_model.dart';
part 'merchant_request_model.g.dart';

@JsonSerializable()
class MerchantRequestModel {
  String query;
  String productName;
  LocationModel location;

  MerchantRequestModel({
    this.query,
    this.productName,
    this.location,
  });

  factory MerchantRequestModel.fromJson(Map<String, dynamic> json) => _$MerchantRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantRequestModelToJson(this);
}
