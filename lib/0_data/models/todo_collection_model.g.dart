// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoCollectionModel _$TodoCollectionModelFromJson(Map<String, dynamic> json) =>
    TodoCollectionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      colorIndex: (json['colorIndex'] as num).toInt(),
    );

Map<String, dynamic> _$TodoCollectionModelToJson(
  TodoCollectionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'colorIndex': instance.colorIndex,
};
