import 'package:json_annotation/json_annotation.dart';
import 'package:vf_user_flutter_new/models/home/merchant_location_model.dart';

import 'merchant_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  ProductModel({
    this.location,
    this.category,
    this.quantity,
    this.status,
    this.id,
    this.name,
    this.bulkQuantity,
    this.description,
    this.merchant,
    this.image,
    this.diet,
    this.price,
    this.distance,
    this.endTime,
    this.startTime,
    this.mainProductModelId,
    this.reviews,
    this.createdTime,
    this.updatedTime,
    this.quickItem,
    this.v,
  });

  MerchantLocationModel location;
  List<String> category;
  int quantity;
  String status;
  String id;
  String name;
  int bulkQuantity;
  String description;
  MerchantModel merchant;
  List<String> image;
  String diet;
  double price;
  String distance;
  DateTime endTime;
  DateTime startTime;
  String mainProductModelId;
  List<dynamic> reviews;
  DateTime createdTime;
  DateTime updatedTime;
  bool quickItem;
  int v;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
