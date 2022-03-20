
import 'package:buildup/features/users/forms/form_item.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bu_form.freezed.dart';
part 'bu_form.g.dart';

@freezed
@immutable
class BuForm with _$BuForm {
  const factory BuForm(String? id, {
    @Default(<FormItem>[]) List<FormItem> items
  }) = _BuForm;

  factory BuForm.fromJson(Map<String, dynamic> json) => _$BuFormFromJson(json);
}