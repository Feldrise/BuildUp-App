import 'package:buildup/entities/project.dart';
import 'package:buildup/entities/user.dart';
import 'package:flutter/material.dart';

mixin BuilderStatus {
  static const String candidating = "Candidating";
  static const String validated = "Validated";
  static const String deleted = "Deleted";
}

mixin BuilderSteps {
  static const String preselected = "Preselected";
  static const String adminMeeting = "AdminMeeting";
  static const String coachMeeting = "CoachMeeting";
  static const String active = "Active";
  static const String finished = "Finished";
  static const String abandoned = "Abandoned";
}


class BuBuilder {
  final String id;
  final User associatedUser;
  final List<Project> associatedProjects = [];

  String coachId;

  String status;
  String step;

  int department;
  String situation;
  String description;

  BuBuilder.fromMap(Map<String, dynamic> map, { @required this.associatedUser}) :
    id = map['id'] as String,
    coachId = map['coachId'] as String,
    status = map['status'] as String,
    step = map['step'] as String,
    department = map['department'] as int,
    situation = map['situation'] as String,
    description = map['description'] as String;

}