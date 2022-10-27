import 'package:json_annotation/json_annotation.dart';
part 'search_item_model.g.dart';

@JsonSerializable()
class SearchItemModel {
  SearchItemModel({
    this.id,
    this.name,
    this.image,
    this.type,
    this.profilePic,
  });

  String id;
  String name;
  String image;
  String type;
  String profilePic;

  factory SearchItemModel.fromJson(Map<String, dynamic> json) => _$SearchItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchItemModelToJson(this);
}
