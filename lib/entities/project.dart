import 'package:buildup/entities/buildons/buildon_returning.dart';

mixin ProjectCategories {
  static const String agroalimentaire = "Agro alimentaire";
  static const String etudesEtConseils = "Etudes et conseils";
  static const String education = "Education";
  static const String communication = "Communication";
  static const String textile = "Textile";
  static const String serviceEntreprise = "Service entreprise";
  static const String commerce = "Commerce";
  static const String jeuxVideos = "Jeux vidéo";
  static const String informatique = "Informatique";
  static const String electronique = "Electronique";
  static const String audiovisuel = "Audiovisuel";
  static const String musique = "Musique";
  static const String other = "Autre";

  static const Map<String, String> map = {
    agroalimentaire: "Agro alimentaire",
    etudesEtConseils: "Etudes et conseils",
    education: "Education",
    communication: "Communication",
    textile: "Textile",
    serviceEntreprise: "Service entreprise",
    commerce: "Commerce",
    jeuxVideos: "Jeux vidéo",
    informatique: "Informatique",
    electronique: "Electronique",
    audiovisuel: "Audiovisuel",
    musique: "Musique",
    other: "Autre",
  };
}

class Project {
  final String id;

  String name;
  String categorie;
  String description;
  String keywords;
  String team;

  DateTime launchDate;

  bool isLucrative;
  bool isDeclared;

  String? currentBuildOn;
  String? currentBuildOnStep;

  bool hasNotification;
  Map<String, BuildOnReturning> associatedReturnings;

  Project.fromMap(Map<String, dynamic> map, {required this.associatedReturnings, this.hasNotification = false}) : 
    id = map['id'] as String,
    name = map['name'] as String,
    categorie = map['categorie'] as String,
    description = map['description'] as String,
    keywords = map['keywords'] as String,
    team = map['team'] as String,
    launchDate = DateTime.tryParse(map['launchDate'] as String) ?? DateTime.now(),
    isLucrative = map['isLucratif'] as bool,
    isDeclared = map['isDeclared'] as bool,
    currentBuildOn = map['currentBuildOn'] as String?,
    currentBuildOnStep = map['currentBuildOnStep'] as String?;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": name,
      "categorie": categorie,
      "description": description,
      "keywords": keywords,
      "team": team,
      "launchDate": launchDate.toIso8601String(),
      "isLucratif": isLucrative,
      "isDeclared": isDeclared
    };
  }
}