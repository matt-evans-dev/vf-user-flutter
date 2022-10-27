// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReviewModel _$ProductReviewModelFromJson(Map<String, dynamic> json) {
  return ProductReviewModel(
    id: json['id'] as String,
    userName: json['userName'] as String,
    description: json['description'] as String,
    rating: json['rating'] as int,
  );
}

Map<String, dynamic> _$ProductReviewModelToJson(ProductReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'description': instance.description,
      'rating': instance.rating,
    };
