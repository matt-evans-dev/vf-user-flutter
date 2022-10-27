import 'package:json_annotation/json_annotation.dart';

part 'product_review_model.g.dart';

@JsonSerializable()
class ProductReviewModel {
  ProductReviewModel({
    this.id,
    this.userName,
    this.description,
    this.rating,
  });

  String id;
  String userName;
  String description;
  int rating;

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) => _$ProductReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewModelToJson(this);
}
