import 'package:json_annotation/json_annotation.dart';
part 'merchant_location_model.g.dart';

@JsonSerializable()
class MerchantLocationModel {
  MerchantLocationModel({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory MerchantLocationModel.fromJson(Map<String, dynamic> json) => _$MerchantLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantLocationModelToJson(this);
}
