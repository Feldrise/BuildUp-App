import 'package:buildup/features/authentication/user.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coach.freezed.dart';
part 'coach.g.dart';

@immutable
@freezed
class Coach with _$Coach {
  const factory Coach({
    required String description,
    @Default("Situation Inconnue") String situation,
    List<User>? builders 
  }) = _Coach;

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);
}