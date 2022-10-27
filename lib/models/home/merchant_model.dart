import 'package:json_annotation/json_annotation.dart';
import 'address_model.dart';
part 'merchant_model.g.dart';

@JsonSerializable()
class MerchantModel {
  MerchantModel({
    this.location,
    this.address,
    this.totalRating,
    this.reviewCount,
    this.id,
    this.name,
    this.images,
    this.taxPercent,
    this.stripeAccountId,
    this.profilePic,
  });

  MerchantModel location;
  AddressModel address;
  double totalRating;
  String id;
  String name;
  List<String> images;
  String profilePic;
  double taxPercent;
  String stripeAccountId;
  int reviewCount;

  factory MerchantModel.fromJson(Map<String, dynamic> json) => _$MerchantModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantModelToJson(this);
}
