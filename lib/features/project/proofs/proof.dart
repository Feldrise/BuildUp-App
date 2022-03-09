import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'proof.freezed.dart';
part 'proof.g.dart';

mixin ProofStatus {
  static const completed = "VALIDATED";
  static const waiting = "WAITING";
}

@immutable
@freezed
class Proof with _$Proof {
  const factory Proof(String? id, {
    required String stepID,
    required String type,
    required String status,
    String? comment
  }) = _Proof;

  factory Proof.fromJson(Map<String, dynamic> json) => _$ProofFromJson(json);
}