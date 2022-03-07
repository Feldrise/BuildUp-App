// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buildon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BuildOn _$$_BuildOnFromJson(Map<String, dynamic> json) => _$_BuildOn(
      json['id'] as String?,
      name: json['name'] as String,
      index: json['index'] as int,
      description:
          json['description'] as String? ?? "Pas de description fournis",
      annexeUrl: json['annexeUrl'] as String? ?? "Pas d'URL",
      rewards: json['rewards'] as String? ?? "Pas d'information",
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => BuildOnStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BuildOnStep>[],
    );

Map<String, dynamic> _$$_BuildOnToJson(_$_BuildOn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'index': instance.index,
      'description': instance.description,
      'annexeUrl': instance.annexeUrl,
      'rewards': instance.rewards,
      'steps': instance.steps,
    };
