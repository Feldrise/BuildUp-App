import 'dart:convert';

import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/entities/forms/bu_form.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/coachs_services.dart';
import 'package:flutter/material.dart';

mixin CoachStatus {
  static const String candidating = "Candidating";
  static const String validated = "Validated";
  static const String deleted = "Deleted";

  static const Map<String, String> detailled = {
    candidating: "En attente",
    validated: "Validée",
    deleted: "Refusée"
  };
}

mixin CoachSteps {
  static const String preselected = "Preselected";
  static const String meeting = "Meeting";
  static const String active = "Active";
  static const String stopped = "Stopped";

  static const Map<String, String> detailled = {
    preselected: "Présélectionné",
    meeting: "Entretient avec un responsable",
    active: "Actif",
    stopped: "Arrêté"
  };
}


class Coach {
  final String id;
  final User associatedUser;
  final BuForm associatedForm;

  BuImage coachCard;

  DateTime candidatingDate;

  String status;
  String step;

  int department;
  String situation;
  String description;

  Coach.fromMap(Map<String, dynamic> map, { @required this.associatedUser, @required this.associatedForm}) :
    id = map['id'] as String,
    coachCard = BuImage("${CoachsService.instance.serviceBaseUrl}/${map['id'] as String}/card"),
    candidatingDate = DateTime.tryParse(map['candidatingDate'] as String),
    status = map['status'] as String,
    step = map['step'] as String,
    department = map['department'] as int,
    situation = map['situation'] as String,
    description = map['description'] as String;

  Map<String, dynamic> toJson() {
    String coachCardString;

    if (!coachCard.isImageEvenWithServer && coachCard.image != null) {
      coachCardString = base64Encode(coachCard.image.bytes);
    }


    return <String, dynamic>{
      "coachCard": coachCardString,
      "userId": associatedUser.id,
      "status": status,
      "step": step,
      "department": department,
      "situation": situation,
      "description": description
    };
  }
}