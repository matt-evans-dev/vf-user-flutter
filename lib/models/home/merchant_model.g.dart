// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantModel _$MerchantModelFromJson(Map<String, dynamic> json) {
  return MerchantModel(
    location: json['location'] == null ? null : MerchantModel.fromJson(json['location'] as Map<String, dynamic>),
    address: json['address'] == null ? null : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    totalRating: (json['totalRating'] as num)?.toDouble(),
    reviewCount: json['reviewCount'] as int,
    id: json['_id'] == null ? json['id'] : json['_id'] as String,
    name: json['name'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
    taxPercent: (json['taxPercent'] as num)?.toDouble(),
    stripeAccountId: json['stripeAccountId'] as String,
    profilePic: json['profilePic'] as String,
  );
}

Map<String, dynamic> _$MerchantModelToJson(MerchantModel instance) => <String, dynamic>{
      'location': instance.location,
      'address': instance.address,
      'totalRating': instance.totalRating,
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
      'profilePic': instance.profilePic,
      'taxPercent': instance.taxPercent,
      'stripeAccountId': instance.stripeAccountId,
      'reviewCount': instance.reviewCount,
    };
