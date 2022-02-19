// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Coach _$$_CoachFromJson(Map<String, dynamic> json) => _$_Coach(
      description: json['description'] as String,
      situation: json['situation'] as String? ?? "Situation Inconnue",
      builders: (json['builders'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CoachToJson(_$_Coach instance) => <String, dynamic>{
      'description': instance.description,
      'situation': instance.situation,
      'builders': instance.builders,
    };
