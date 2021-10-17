// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoById _$PhotoByIdFromJson(Map<String, dynamic> json) => PhotoById(
      json['id'] as int?,
      json['name'] as String?,
      json['path'] as String?,
      json['updatedAt'] as String?,
    );

Map<String, dynamic> _$PhotoByIdToJson(PhotoById instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
      'updatedAt': instance.updatedAt,
    };

AllPhoto _$AllPhotoFromJson(Map<String, dynamic> json) => AllPhoto(
      json['id'] as int,
      json['memberId'] as int?,
      json['memberName'] as String?,
      json['name'] as String,
      json['path'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$AllPhotoToJson(AllPhoto instance) => <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'name': instance.name,
      'path': instance.path,
      'updatedAt': instance.updatedAt,
    };
