import 'package:buildup/features/project/project.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bu_builder.freezed.dart';
part 'bu_builder.g.dart';

@immutable
@freezed
class BuBuilder with _$BuBuilder {
  const factory BuBuilder({
    Project? project
  }) = _BuBuilder;

  factory BuBuilder.fromJson(Map<String, dynamic> json) => _$BuBuilderFromJson(json);
}