import 'package:buildup/features/authentication/user.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_state.freezed.dart';

@immutable
@freezed
class AppUserState with _$AppUserState {
  const factory AppUserState({
    String? token,
  }) = _AppUserState;
}