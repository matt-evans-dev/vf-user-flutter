// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    location: json['location'] == null ? null : MerchantLocationModel.fromJson(json['location'] as Map<String, dynamic>),
    category: (json['category'] as List)?.map((e) => e as String)?.toList(),
    quantity: json['quantity'] as int,
    status: json['status'] as String,
    id: json['_id'] as String,
    name: json['name'] as String,
    bulkQuantity: json['bulkQuantity'] as int,
    description: json['description'] as String,
    merchant: json['merchant'] == null ? null : MerchantModel.fromJson(json['merchant'] as Map<String, dynamic>),
    image: (json['image'] as List)?.map((e) => e as String)?.toList(),
    diet: json['diet'] as String,
    price: (json['price'] as num)?.toDouble(),
    distance: json['distance'] as String,
    endTime: json['endTime'] == null ? null : DateTime.parse(json['endTime'] as String),
    startTime: json['startTime'] == null ? null : DateTime.parse(json['startTime'] as String),
    mainProductModelId: json['mainProductModelId'] as String,
    reviews: json['reviews'] as List,
    createdTime: json['createdTime'] == null ? null : DateTime.parse(json['createdTime'] as String),
    updatedTime: json['updatedTime'] == null ? null : DateTime.parse(json['updatedTime'] as String),
    quickItem: json['quickItem'] as bool,
    v: json['v'] as int,
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) => <String, dynamic>{
      'location': instance.location,
      'category': instance.category,
      'quantity': instance.quantity,
      'status': instance.status,
      'id': instance.id,
      'name': instance.name,
      'bulkQuantity': instance.bulkQuantity,
      'description': instance.description,
      'merchant': instance.merchant,
      'image': instance.image,
      'diet': instance.diet,
      'price': instance.price,
      'distance': instance.distance,
      'endTime': instance.endTime?.toIso8601String(),
      'startTime': instance.startTime?.toIso8601String(),
      'mainProductModelId': instance.mainProductModelId,
      'reviews': instance.reviews,
      'createdTime': instance.createdTime?.toIso8601String(),
      'updatedTime': instance.updatedTime?.toIso8601String(),
      'quickItem': instance.quickItem,
      'v': instance.v,
    };
