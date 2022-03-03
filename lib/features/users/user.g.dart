// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      json['id'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      role: json['role'] as String,
      description: json['description'] as String,
      status: json['status'] as String? ?? "UNKNOWN",
      step: json['step'] as String? ?? "UNKNOWN",
      situation: json['situation'] as String? ?? "Situation Inconnue",
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      address: json['address'] as String?,
      discord: json['discord'] as String?,
      linkedin: json['linkedin'] as String?,
      builder: json['builder'] == null
          ? null
          : BuBuilder.fromJson(json['builder'] as Map<String, dynamic>),
      coach: json['coach'] == null
          ? null
          : Coach.fromJson(json['coach'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'role': instance.role,
      'description': instance.description,
      'status': instance.status,
      'step': instance.step,
      'situation': instance.situation,
      'createdAt': instance.createdAt?.toIso8601String(),
      'birthday': instance.birthday?.toIso8601String(),
      'address': instance.address,
      'discord': instance.discord,
      'linkedin': instance.linkedin,
      'builder': instance.builder,
      'coach': instance.coach,
    };
