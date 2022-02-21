// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Project _$$_ProjectFromJson(Map<String, dynamic> json) => _$_Project(
      name: json['name'] as String,
      description: json['description'] as String,
      keywords: json['keywords'] as String?,
      categorie: json['categorie'] as String?,
      team: json['team'] as String?,
      launchDate: json['launchDate'] == null
          ? null
          : DateTime.parse(json['launchDate'] as String),
      isLucarative: json['isLucarative'] as bool?,
      isOfficialyRegistered: json['isOfficialyRegistered'] as bool?,
    );

Map<String, dynamic> _$$_ProjectToJson(_$_Project instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'keywords': instance.keywords,
      'categorie': instance.categorie,
      'team': instance.team,
      'launchDate': instance.launchDate?.toIso8601String(),
      'isLucarative': instance.isLucarative,
      'isOfficialyRegistered': instance.isOfficialyRegistered,
    };
