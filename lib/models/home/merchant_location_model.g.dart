// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantLocationModel _$MerchantLocationModelFromJson(
    Map<String, dynamic> json) {
  return MerchantLocationModel(
    type: json['type'] as String,
    coordinates: (json['coordinates'] as List)
        ?.map((e) => (e as num)?.toDouble())
        ?.toList(),
  );
}

Map<String, dynamic> _$MerchantLocationModelToJson(
        MerchantLocationModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
