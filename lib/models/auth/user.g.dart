// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    accountStatus: json['accountStatus'] as String,
    countryCode: json['countryCode'] as String,
    createdTime: json['createdTime'] as String,
    deliveryAddress: json['deliveryAddress'] as List,
    deviceIds: json['deviceIds'] as List,
    email: json['email'] as String,
    fcmToken: json['fcmToken'] as List,
    id: json['id'] as String,
    location: json['location'] as Map<String, dynamic>,
    loginType: json['loginType'] as String,
    mobile: json['mobile'] as String,
    otp: json['otp'] as String,
    profilePic: json['profilePic'] as String,
    signupType: json['signupType'] as String,
    stripeId: json['stripeId'] as String,
    updatedTime: json['updatedTime'] as String,
    userName: json['userName'] as String,
    userId: json['_id'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'accountStatus': instance.accountStatus,
      'countryCode': instance.countryCode,
      'createdTime': instance.createdTime,
      'deliveryAddress': instance.deliveryAddress,
      'deviceIds': instance.deviceIds,
      'email': instance.email,
      'fcmToken': instance.fcmToken,
      'id': instance.id,
      'location': instance.location,
      'loginType': instance.loginType,
      'mobile': instance.mobile,
      'otp': instance.otp,
      'profilePic': instance.profilePic,
      'signupType': instance.signupType,
      'stripeId': instance.stripeId,
      'updatedTime': instance.updatedTime,
      'userName': instance.userName,
      '_id': instance.userId,
    };
