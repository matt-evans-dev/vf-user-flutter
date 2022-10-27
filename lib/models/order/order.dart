import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  String status;
  String orderStatus;
  String id;
  String description;
  double totalAmount;
  int totalItem;
  double itemTotal;
  double tax;
  List<Item> items;
  UserOrder user;
  Merchant merchant;
  int userRating;
  String orderId;
  bool rated;
  DateTime updatedTime;
  double price;

  Order(
      {this.status,
      this.orderStatus,
      this.id,
      this.description,
      this.totalAmount,
      this.totalItem,
      this.itemTotal,
      this.tax,
      this.items,
      this.user,
      this.merchant,
      this.userRating,
      this.orderId,
      this.rated,
      this.updatedTime,
      this.price});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

class Item {
  Item({
    this.id,
    this.itemId,
    this.name,
    this.price,
    this.quantity,
  });

  String id;
  String itemId;
  String name;
  double price;
  int quantity;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

class Merchant {
  Merchant({
    this.location,
    this.address,
    this.images,
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.merchantId,
    this.profilePic,
  });

  Location location;
  Address address;
  List<String> images;
  String id;
  String name;
  String email;
  String mobile;
  String merchantId;
  String profilePic;

  factory Merchant.fromJson(Map<String, dynamic> json) => _$MerchantFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantToJson(this);
}

class Address {
  Address({
    this.name,
    this.pincode,
  });

  String name;
  String pincode;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

class Location {
  Location({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

class UserOrder {
  UserOrder({
    this.location,
    this.id,
    this.userName,
    this.email,
    this.profilePic,
    this.mobile,
    this.userId,
  });

  Location location;
  String id;
  String userName;
  String email;
  String profilePic;
  String mobile;
  String userId;

  factory UserOrder.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
