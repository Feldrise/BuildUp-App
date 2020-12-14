import 'dart:convert';

import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/entities/forms/bu_form.dart';
import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/entities/project.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:flutter/material.dart';

import 'coach.dart';

mixin BuilderStatus {
  static const String candidating = "Candidating";
  static const String validated = "Validated";
  static const String deleted = "Deleted";

  static const Map<String, String> detailled = {
    candidating: "En attente",
    validated: "Validée",
    deleted: "Refusée"
  };
}

mixin BuilderSteps {
  static const String preselected = "Preselected";
  static const String adminMeeting = "AdminMeeting";
  static const String coachMeeting = "CoachMeeting";
  static const String active = "Active";
  static const String finished = "Finished";
  static const String abandoned = "Abandoned";

  static const Map<String, String> detailled = {
    preselected: "Présélectionné",
    adminMeeting: "Entretien avec un responsable",
    coachMeeting: "Choix coach",
    active: "Actif",
    finished: "Fin programme",
    abandoned: "Abandon"
  };
}

class BuBuilder {
  final String id;
  final User associatedUser;
  final List<Project> associatedProjects = [];
  final BuForm associatedForm;

  BuImage builderCard;

  Coach associatedCoach;
  NtfReferent associatedNtfReferent;

  DateTime programEndDate;
  String status;
  String step;

  int department;
  String situation;
  String description;

  BuBuilder.fromMap(Map<String, dynamic> map, { @required this.associatedUser, @required this.associatedForm, this.associatedCoach, this.associatedNtfReferent}) :
    id = map['id'] as String,
    builderCard = BuImage("${BuildersService.instance.serviceBaseUrl}/${map['id'] as String}/card"),
    programEndDate = DateTime.tryParse(map['programEndDate'] as String),
    status = map['status'] as String,
    step = map['step'] as String,
    department = map['department'] as int,
    situation = map['situation'] as String,
    description = map['description'] as String;

  Map<String, dynamic> toJson() {
    String builderCardString;

    if (!builderCard.isImageEvenWithServer && builderCard.image != null) {
      builderCardString = base64Encode(builderCard.image.bytes);
    }

    return <String, dynamic>{
      "builderCard": builderCardString,
      "userId": associatedUser.id,
      "coachId": associatedCoach?.id,
      "ntfReferentId": associatedNtfReferent?.id,
      "programEndDate": programEndDate?.toIso8601String(),
      "status": status,
      "step": step,
      "department": department,
      "situation": situation,
      "description": description
    };
  }
}