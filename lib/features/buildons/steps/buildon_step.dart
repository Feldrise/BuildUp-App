import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buildon_step.freezed.dart';
part 'buildon_step.g.dart';

mixin BuildOnStepProofType {
  static const comment = "COMMENT";
  static const file = "FILE";

  static const Map<String, String> detailled = {
    comment: "Un commentaire",
    file: "Un fichier"
  };
}

@immutable
@freezed
class BuildOnStep with _$BuildOnStep {
  const factory BuildOnStep(String? id, {
    required String name,
    required int index,
    @Default("Pas de description fournis") String description,
    @Default("Pas d'information") String proofType,
    @Default("Pas d'information") String proofDescription
  }) = _BuildOnStep;

  factory BuildOnStep.fromJson(Map<String, dynamic> json) => _$BuildOnStepFromJson(json);
}