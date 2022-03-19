import 'package:buildup/core/models/bu_file.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buildon.freezed.dart';
part 'buildon.g.dart';

@immutable
@freezed
class BuildOn with _$BuildOn {
  const factory BuildOn(String? id, {
    required String name,
    required int index,
    @Default("Pas de description fournis") String description,
    @Default("Pas d'URL") String annexeUrl,
    @Default("Pas d'information") String rewards,
    @Default(<BuildOnStep>[]) List<BuildOnStep> steps,
    @JsonKey(ignore: true) BuFile? image,
  }) = _BuildOn;

  factory BuildOn.fromJson(Map<String, dynamic> json) => _$BuildOnFromJson(json);
}