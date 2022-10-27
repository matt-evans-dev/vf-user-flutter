// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) {
  return CartItemModel(
    quantity: json['quantity'] as int,
    id: json['id'] as String,
    user: json['user'] as String,
    product: json['product'] as String,
    productName: json['productName'] as String,
    productPrice: (json['productPrice'] as num)?.toDouble(),
    getCartResId: json['getCartResId'] as String,
    productQuantity: json['productQuantity'] as int,
    bulkQuantity: json['bulkQuantity'] as int,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'id': instance.id,
      'user': instance.user,
      'product': instance.product,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'getCartResId': instance.getCartResId,
      'productQuantity': instance.productQuantity,
      'bulkQuantity': instance.bulkQuantity,
      'images': instance.images,
    };

MerchantCart _$MerchantCartModelFromJson(Map<String, dynamic> json) {
  return MerchantCart(
    merchant: json['merchant'],
    merchantCartItems: json['merchantCartItems'],
  );
}

Map<String, dynamic> _$MerchantCartModelToJson(MerchantCart instance) => <String, dynamic>{
      'merchant': instance.merchant,
      'merchantCartItems': instance.merchantCartItems,
    };
