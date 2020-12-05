class Project {
  final String id;

  String name;
  String description;
  String keywords;
  String team;

  DateTime launchDate;

  bool isLucrative;

  Project.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String,
    name = map['name'] as String,
    description = map['description'] as String,
    keywords = map['keywords'] as String,
    team = map['team'] as String,
    launchDate = DateTime.tryParse(map['launchDate'] as String),
    isLucrative = map['isLucratif'] as bool;
}