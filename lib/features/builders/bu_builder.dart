import 'package:buildup/features/project/project.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bu_builder.freezed.dart';
part 'bu_builder.g.dart';

mixin BuilderSteps {
  static const String unknown = "UNKNOWN";
  static const String preselected = "PRESELECTED";
  static const String adminMeeting = "ADMIN_MEETING";
  static const String adminMeetingDone = "ADMIN_MEETING_DONE";
  static const String coachMeeting = "COACH_MEETING";
  static const String signing = "SIGNING";
  static const String active = "ACTIVE";
  static const String finished = "FINISHED";
  static const String abandoned = "ABANDONNED";

  static const Map<String, String> detailled = {
    unknown: "Inconnue",
    preselected: "Présélectionné",
    adminMeeting: "Entretien avec un responsable",
    adminMeetingDone : "Entretien avec un responsable terminé",
    coachMeeting: "Choix coach",
    signing: "Signature",
    active: "Actif",
    finished: "Fin programme",
    abandoned: "Abasndon"
  };
}

@immutable
@freezed
class BuBuilder with _$BuBuilder {
  const factory BuBuilder({
    Project? project
  }) = _BuBuilder;

  factory BuBuilder.fromJson(Map<String, dynamic> json) => _$BuBuilderFromJson(json);
}