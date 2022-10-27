// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) {
  return PlaceModel(
    json['description'] as String,
    json['place_id'] as String,
  );
}

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) => <String, dynamic>{
      'description': instance.description,
      'place_id': instance.placeId,
    };
