// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    status: json["status"],
    orderStatus: json["orderStatus"],
    id: json["_id"],
    description: json["description"],
    totalAmount: json["totalAmount"] / 100,
    totalItem: json["totalItem"],
    itemTotal: json["itemTotal"] != null ? json["itemTotal"] / 100 : 0,
    tax: json["tax"] != null ? json["tax"] : 0,
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    user: UserOrder.fromJson(json["user"]),
    rated: json["rated"],
    merchant: Merchant.fromJson(json["merchant"]),
    userRating: json["userRating"],
    orderId: json["id"],
    price: json["price"],
    updatedTime: json["updatedTime"] != null ? DateTime.parse(json["updatedTime"]) : null,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      "status": instance.status,
      "orderStatus": instance.orderStatus,
      "_id": instance.id,
      "description": instance.description,
      "totalAmount": instance.totalAmount,
      "totalItem": instance.totalItem,
      "items": List<dynamic>.from(instance.items.map((x) => x.toJson())),
      "itemTotal": instance.itemTotal,
      "tax": instance.tax,
      "user": instance.user.toJson(),
      "rated": instance.rated,
      "merchant": instance.merchant.toJson(),
      "userRating": instance.userRating,
      "id": instance.orderId,
      "updatedTime": instance.updatedTime.toIso8601String(),
      "price": instance.price,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json["_id"],
    itemId: json["id"],
    name: json["name"],
    price: json["price"] != null ? json["price"].toDouble() : 0.0,
    quantity: json["quantity"],
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      "_id": instance.id,
      "id": instance.itemId,
      "name": instance.name,
      "price": instance.price,
      "quantity": instance.quantity,
    };

Merchant _$MerchantFromJson(Map<String, dynamic> json) {
  return Merchant(
      location: Location.fromJson(json["location"]),
      address: Address.fromJson(json["address"]),
      images: List<String>.from(json["images"].map((x) => x)),
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      mobile: json["mobile"],
      merchantId: json["id"],
      profilePic: json["profilePic"]);
}

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
      "location": instance.location.toJson(),
      "address": instance.address.toJson(),
      "images": List<dynamic>.from(instance.images.map((x) => x)),
      "_id": instance.id,
      "name": instance.name,
      "email": instance.email,
      "mobile": instance.mobile,
      "id": instance.merchantId,
      "profilePic": instance.profilePic,
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    name: json["name"],
    pincode: json["pincode"],
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      "name": instance.name,
      "pincode": instance.pincode,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    type: json["type"],
    coordinates: List<double>.from(
      json["coordinates"].map((x) => x.toDouble()),
    ),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      "type": instance.type,
      "coordinates": List<dynamic>.from(instance.coordinates.map((x) => x)),
    };

UserOrder _$UserFromJson(Map<String, dynamic> json) {
  return UserOrder(
    location: Location.fromJson(json["location"]),
    id: json["_id"],
    userName: json["userName"],
    email: json["email"],
    profilePic: json["profilePic"],
    mobile: json["mobile"],
    userId: json["id"],
  );
}

Map<String, dynamic> _$UserToJson(UserOrder instance) => <String, dynamic>{
      "location": instance.location.toJson(),
      "_id": instance.id,
      "userName": instance.userName,
      "email": instance.email,
      "profilePic": instance.profilePic,
      "mobile": instance.mobile,
      "id": instance.userId,
    };
