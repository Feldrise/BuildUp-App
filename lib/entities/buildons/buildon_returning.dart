import 'dart:convert';

import 'package:buildup/entities/bu_file.dart';

mixin BuildOnReturningType {
  static const String file = "File";
  static const String link = "External";
  static const String comment = "Comment";

  static const Map<String, String> detailled = {
    file: "Fichier",
    link: "Rendu externe (lien)",
    comment: "Commentaire"

  };
}

mixin BuildOnReturningStatus {
  static const String validated = "Validated";
  static const String waiting = "Waiting";
  static const String waitingCoach = "WaitingCoach";
  static const String waitingAdmin = "WaitingAdmin";
  static const String refused = "Refused";

  static const Map<String, String> detailled = {
    validated: "Validé",
    waiting: "En attente",
    waitingCoach: "En attente du Coach",
    waitingAdmin: "En attente d'un responsable",
    refused: "Refusé"
  };
}

class BuildOnReturning {
  String id;
  String buildOnStepId;
  String type;
  String status;

  BuFile file;
  String comment;

  BuildOnReturning(this.id, {
    this.buildOnStepId,
    this.type,
    this.status,
    this.file,
    this.comment
  });

  BuildOnReturning.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String,
    buildOnStepId = map['buildOnStepId'] as String,
    type = map['type'] as String,
    status = map['status'] as String,
    comment = map['comment'] as String {
    file = BuFile(
      map['fileId'] as String,
      fileName: map['fileName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "buildOnStepId": buildOnStepId,
      "type": type,
      "fileName": file?.fileName,
      "file": file?.data != null ? base64Encode(file.data) : null,
      "comment": comment
    };
  }
}