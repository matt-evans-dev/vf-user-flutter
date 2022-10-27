import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String accountStatus;
  String countryCode;
  String createdTime;
  List<dynamic> deliveryAddress;
  List<dynamic> deviceIds;
  String email;
  List<dynamic> fcmToken;
  String id;
  Map<String, dynamic> location;
  String loginType;
  String mobile;
  String otp;
  String profilePic;
  String signupType;
  String stripeId;
  String updatedTime;
  String userName;
  String userId;

  User({
    this.accountStatus,
    this.countryCode,
    this.createdTime,
    this.deliveryAddress,
    this.deviceIds,
    this.email,
    this.fcmToken,
    this.id,
    this.location,
    this.loginType,
    this.mobile,
    this.otp,
    this.profilePic,
    this.signupType,
    this.stripeId,
    this.updatedTime,
    this.userName,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
