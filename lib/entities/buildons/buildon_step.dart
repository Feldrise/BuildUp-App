class BuildOnStep {
  String id;

  String imageId;

  String name;
  String description;
  String proofDescription;

  BuildOnStep() :
    name = "",
    description = "",
    proofDescription = "";

  BuildOnStep.fromMap(Map<String, dynamic> map) :
    id = map['id'] as String,
    imageId = map['imageId'] as String,
    name = map['name'] as String,
    description = map['description'] as String,
    proofDescription = map['proofDescription'] as String;
}