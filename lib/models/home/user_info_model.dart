import 'location_model.dart';

class UserInfo {
  UserInfo({
    this.location,
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.password,
    this.loginType,
    this.profilePic,
    this.signupType,
    this.userInfoId,
    this.deliveryAddress,
    this.stripeId,
    this.createdTime,
    this.updatedTime,
    this.v,
  });

  LocationModel location;
  String id;
  String userName;
  String firstName;
  String lastName;
  String email;
  String mobile;
  String password;
  String loginType;
  String profilePic;
  String signupType;
  String userInfoId;
  String stripeId;
  List<dynamic> deliveryAddress;
  DateTime createdTime;
  DateTime updatedTime;
  int v;
}
