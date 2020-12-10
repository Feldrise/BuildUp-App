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
  static const String refused = "Refused";

  static const Map<String, String> detailled = {
    validated: "Validé",
    waiting: "En attente",
    refused: "Refusé"
  };
}

class BuildOnReturning {
  String id;
  String buildOnStepId;
  String type;
  String status;

  String fileName;
  String fileId;
  String comment;

  BuildOnReturning.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String,
    buildOnStepId = map['buildOnStepId'] as String,
    type = map['type'] as String,
    status = map['status'] as String,
    fileName = map['fileName'] as String,
    fileId = map['fileId'] as String,
    comment = map['comment'] as String;
}