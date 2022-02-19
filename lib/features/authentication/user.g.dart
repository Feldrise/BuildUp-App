// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      role: json['role'] as String,
      step: json['step'] as String,
      builder: json['builder'] == null
          ? null
          : BuBuilder.fromJson(json['builder'] as Map<String, dynamic>),
      coach: json['coach'] == null
          ? null
          : Coach.fromJson(json['coach'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'role': instance.role,
      'step': instance.step,
      'builder': instance.builder,
      'coach': instance.coach,
    };
