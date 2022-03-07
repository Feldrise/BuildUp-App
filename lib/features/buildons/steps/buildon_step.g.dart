// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buildon_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BuildOnStep _$$_BuildOnStepFromJson(Map<String, dynamic> json) =>
    _$_BuildOnStep(
      json['id'] as String?,
      name: json['name'] as String,
      index: json['index'] as int,
      description:
          json['description'] as String? ?? "Pas de description fournis",
      proofType: json['proofType'] as String? ?? "Pas d'information",
      proofDescription:
          json['proofDescription'] as String? ?? "Pas d'information",
    );

Map<String, dynamic> _$$_BuildOnStepToJson(_$_BuildOnStep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'index': instance.index,
      'description': instance.description,
      'proofType': instance.proofType,
      'proofDescription': instance.proofDescription,
    };
