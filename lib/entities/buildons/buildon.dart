import 'package:buildup/entities/buildons/buildon_step.dart';

class BuildOn {
  String id;

  String imageId;

  String name;
  String description;

  final List<BuildOnStep> steps;

  BuildOn() :
    name = "",
    description = "",
    steps = [];

  BuildOn.fromMap(Map<String, dynamic> map, {this.steps}) :
    id = map['id'] as String,
    imageId = map['imageId'] as String,
    name = map['name'] as String,
    description = map['description'] as String;
}