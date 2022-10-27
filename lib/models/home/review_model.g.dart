// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return ReviewModel(
    id: json['id'] as String,
    user: json['user'] as String,
    merchant: json['merchant'] as String,
    userName: json['userName'] as String,
    userImg: json['userImg'] as String,
    description: json['description'] as String,
    rating: json['rating'] as int,
    createdTime: json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    updatedTime: json['updatedTime'] == null
        ? null
        : DateTime.parse(json['updatedTime'] as String),
    v: json['v'] as int,
  );
}

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'merchant': instance.merchant,
      'userName': instance.userName,
      'userImg': instance.userImg,
      'description': instance.description,
      'rating': instance.rating,
      'createdTime': instance.createdTime?.toIso8601String(),
      'updatedTime': instance.updatedTime?.toIso8601String(),
      'v': instance.v,
    };
