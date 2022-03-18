import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bu_file.freezed.dart';
part 'bu_file.g.dart';

@freezed
@immutable
class BuFile with _$BuFile {
  const factory BuFile({
    @JsonKey(name: "name") required String filename,
    @JsonKey(name: "content") String? base64content
  }) = _BuFile;

  factory BuFile.fromJson(Map<String, dynamic> json) => _$BuFileFromJson(json);
}