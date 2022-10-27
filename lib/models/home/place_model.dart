import 'package:json_annotation/json_annotation.dart';
part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel {
  String description;
  String placeId;

  PlaceModel(this.description, this.placeId);

  factory PlaceModel.fromJson(Map<String, dynamic> json) => _$PlaceModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
