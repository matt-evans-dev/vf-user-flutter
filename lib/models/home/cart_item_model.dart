import 'package:json_annotation/json_annotation.dart';
import 'package:vf_user_flutter_new/models/home/merchant_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  CartItemModel({
    this.quantity,
    this.id,
    this.user,
    this.product,
    this.productName,
    this.productPrice,
    this.getCartResId,
    this.productQuantity,
    this.bulkQuantity,
    this.images,
  });

  int quantity;
  String id;
  String user;
  String product;
  String productName;
  double productPrice;
  String getCartResId;
  int productQuantity;
  int bulkQuantity;
  List<String> images;

  factory CartItemModel.fromJson(Map<String, dynamic> json) => _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}

class MerchantCart {
  MerchantCart({
    this.merchant,
    this.merchantCartItems,
  });

  MerchantModel merchant;
  List<CartItemModel> merchantCartItems;

  factory MerchantCart.fromJson(Map<String, dynamic> json) => _$MerchantCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantCartModelToJson(this);
}
