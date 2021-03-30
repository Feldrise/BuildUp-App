import 'dart:convert';

import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/entities/buildons/buildon_returning.dart';
import 'package:buildup/services/buildons_service.dart';

class BuildOnStep {
  String? id;

  BuImage image;

  String name;
  String description;

  String returningType;
  String returningDescription;
  String returningLink;

  BuildOnStep() :
    name = "",
    image = BuImage(""),
    description = "",
    returningType = BuildOnReturningType.file,
    returningDescription = "",
    returningLink = "";

  BuildOnStep.fromMap(Map<String, dynamic> map) :
    id = map['id'] as String?,
    image = BuImage("${BuildOnsService.instance.serviceBaseUrl}/steps/${map['id'] as String}/image"),
    name = map['name'] as String,
    description = map['description'] as String,
    returningType = map['returningType'] as String,
    returningDescription = map['returningDescription'] as String,
    returningLink = map['returningLink'] as String;

  Map<String, dynamic> toJson() {
    String? imageString;

    if (!image.isImageEvenWithServer && image.image != null) {
      imageString = base64Encode(image.image!.bytes);
    }

    return <String, dynamic>{
      "id": id,
      "image": imageString,
      "name": name,
      "description": description,
      "returningType": returningType,
      "returningDescription": returningDescription,
      "returningLink": returningLink
    };
  }
}