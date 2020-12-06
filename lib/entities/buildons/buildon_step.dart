import 'dart:convert';

import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/services/buildons_service.dart';

class BuildOnStep {
  String id;

  BuImage image;

  String name;
  String description;
  String proofDescription;

  BuildOnStep() :
    name = "",
    image = BuImage(""),
    description = "",
    proofDescription = "";

  BuildOnStep.fromMap(Map<String, dynamic> map) :
    id = map['id'] as String,
    image = BuImage("${BuildOnsService.instance.serviceBaseUrl}/steps/${map['id'] as String}/image"),
    name = map['name'] as String,
    description = map['description'] as String,
    proofDescription = map['proofDescription'] as String;

  Map<String, dynamic> toJson() {
    String imageString;

    if (!image.isImageEvenWithServer && image.image != null) {
      imageString = base64Encode(image.image.bytes);
    }

    return <String, dynamic>{
      "id": id,
      "image": imageString,
      "name": name,
      "description": description,
      "proofDescription": proofDescription
    };
  }
}