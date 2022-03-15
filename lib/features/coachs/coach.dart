import 'package:buildup/features/users/user.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coach.freezed.dart';
part 'coach.g.dart';

mixin CoachSteps {
  static const String unknown = "UNKNOWN";
  static const String preselected = "PRESELECTED";
  static const String meeting = "MEETING";
  static const String meetingDone = "MEETINGDONE";
  static const String signing = "SIGNING";
  static const String active = "ACTIVE";
  static const String stopped = "STOPPED";

  static const Map<String, String> detailled = {
    preselected: "Présélectionné",
    meeting: "Entretien avec un responsable",
    meetingDone: "Entretien avec un responsable réalisé",
    signing: "Signature",
    active: "Actif",
    stopped: "Arrêté"
  };
}


@immutable
@freezed
class Coach with _$Coach {
  const factory Coach({
    List<User>? builders 
  }) = _Coach;

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);
}