// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bu_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BuFile _$$_BuFileFromJson(Map<String, dynamic> json) => _$_BuFile(
      filename: json['name'] as String,
      base64content: json['content'] as String?,
    );

Map<String, dynamic> _$$_BuFileToJson(_$_BuFile instance) => <String, dynamic>{
      'name': instance.filename,
      'content': instance.base64content,
    };
