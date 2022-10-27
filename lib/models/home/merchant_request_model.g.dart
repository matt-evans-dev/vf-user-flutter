// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantRequestModel _$MerchantRequestModelFromJson(Map<String, dynamic> json) {
  return MerchantRequestModel(
    query: json['query'] as String,
    productName: json['productName'] as String,
    location: json['location'] == null
        ? null
        : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MerchantRequestModelToJson(
        MerchantRequestModel instance) =>
    <String, dynamic>{
      'query': instance.query,
      'productName': instance.productName,
      'location': instance.location,
    };
