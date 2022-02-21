import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@immutable
@freezed
class Project with _$Project {
  const factory Project({
    required String name,
    required String description,
    String? keywords,
    String? categorie,
    String? team,
    DateTime? launchDate,
    bool? isLucarative,
    bool? isOfficialyRegistered,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}