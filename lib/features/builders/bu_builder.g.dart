// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bu_builder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BuBuilder _$$_BuBuilderFromJson(Map<String, dynamic> json) => _$_BuBuilder(
      description: json['description'] as String,
      project: json['project'] == null
          ? null
          : Project.fromJson(json['project'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BuBuilderToJson(_$_BuBuilder instance) =>
    <String, dynamic>{
      'description': instance.description,
      'project': instance.project,
    };
