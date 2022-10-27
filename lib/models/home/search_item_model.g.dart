// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchItemModel _$SearchItemModelFromJson(Map<String, dynamic> json) {
  return SearchItemModel(
    id: json['id'] as String,
    name: json['name'] as String,
    image: json['image'] as String,
    type: json['type'] as String,
    profilePic: json['profilePic'] as String,
  );
}

Map<String, dynamic> _$SearchItemModelToJson(SearchItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'type': instance.type,
      'profilePic': instance.profilePic,
    };
