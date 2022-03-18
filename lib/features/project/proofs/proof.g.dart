// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Proof _$$_ProofFromJson(Map<String, dynamic> json) => _$_Proof(
      json['id'] as String?,
      stepID: json['stepID'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      comment: json['comment'] as String?,
      file: json['file'] == null
          ? null
          : BuFile.fromJson(json['file'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ProofToJson(_$_Proof instance) => <String, dynamic>{
      'id': instance.id,
      'stepID': instance.stepID,
      'type': instance.type,
      'status': instance.status,
      'comment': instance.comment,
      'file': instance.file,
    };
