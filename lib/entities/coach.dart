import 'package:buildup/entities/forms/bu_form.dart';
import 'package:buildup/entities/user.dart';
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

  DateTime candidatingDate;

  String status;
  String step;

  int department;
  String situation;
  String description;

  Coach.fromMap(Map<String, dynamic> map, { @required this.associatedUser, @required this.associatedForm}) :
    id = map['id'] as String,
    candidatingDate = DateTime.tryParse(map['candidatingDate'] as String),
    status = map['status'] as String,
    step = map['step'] as String,
    department = map['department'] as int,
    situation = map['situation'] as String,
    description = map['description'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "userId": associatedUser.id,
      "status": status,
      "step": step,
      "department": department,
      "situation": situation,
      "description": description
    };
  }
}