import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_item.freezed.dart';
part 'form_item.g.dart';

@freezed
@immutable
class FormItem with _$FormItem {
  const factory FormItem({
    required String question,
    required String answer
  }) = _FormItem;

  factory FormItem.fromJson(Map<String, dynamic> json) => _$FormItemFromJson(json);
}