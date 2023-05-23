// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      id: json['id'] as int,
      name: json['name'] as String,
      creationDate: DateTime.parse(json['dateCreate'] as String),
      description: json['description'] as String,
      newMedia: json['new'] as bool,
      popular: json['popular'] as bool,
      image: json['image'] == null
          ? null
          : ImageModel.fromJson(json['image'] as Map<String, dynamic>),
      user: json['user'] as String?,
    );

const _$MediaFieldMap = <String, String>{
  'id': 'id',
  'name': 'name',
  'creationDate': 'dateCreate',
  'description': 'description',
  'newMedia': 'new',
  'popular': 'popular',
  'image': 'image',
  'user': 'user',
};

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dateCreate': instance.creationDate.toIso8601String(),
      'description': instance.description,
      'new': instance.newMedia,
      'popular': instance.popular,
      'image': instance.image?.toJson(),
      'user': instance.user,
    };
