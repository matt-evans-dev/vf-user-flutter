import 'package:json_annotation/json_annotation.dart';
part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  ReviewModel({
    this.id,
    this.user,
    this.merchant,
    this.userName,
    this.userImg,
    this.description,
    this.rating,
    this.createdTime,
    this.updatedTime,
    this.v,
  });

  String id;
  String user;
  String merchant;
  String userName;
  String userImg;
  String description;
  int rating;
  DateTime createdTime;
  DateTime updatedTime;
  int v;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
