import 'dart:convert';

import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/services/buildons_service.dart';

class BuildOn {
  String? id;

  BuImage image;

  String name;
  String description;

  final List<BuildOnStep> steps;

  BuildOn() :
    name = "",
    image = BuImage(""),
    description = "",
    steps = [];

  BuildOn.fromMap(Map<String, dynamic> map, {required this.steps}) :
    id = map['id'] as String,
    image = BuImage("${BuildOnsService.instance.serviceBaseUrl}/${map['id'] as String}/image"),
    name = map['name'] as String,
    description = map['description'] as String;

  Map<String, dynamic> toJson() {
    String? imageString;

    if (!image.isImageEvenWithServer && image.image != null) {
      imageString = base64Encode(image.image!.bytes);
    }

    return <String, dynamic>{
      "id": id,
      "image": imageString,
      "name": name,
      "description": description
    };
  }

  void reorderStep({required int oldIndex, required int newIndex}) {
    final item = steps.removeAt(oldIndex);
    steps.insert(newIndex < oldIndex ? newIndex: newIndex - 1, item);
  }
}