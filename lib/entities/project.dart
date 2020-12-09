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

  Project.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String,
    name = map['name'] as String,
    categorie = map['categorie'] as String,
    description = map['description'] as String,
    keywords = map['keywords'] as String,
    team = map['team'] as String,
    launchDate = DateTime.tryParse(map['launchDate'] as String),
    isLucrative = map['isLucratif'] as bool,
    isDeclared = map['isDeclared'] as bool;
}