import 'package:buildup/services/image_service.dart';
import 'package:flutter/material.dart';

class BuImage {
  String source;

  bool isImageEvenWithServer = false;
  MemoryImage image;

  BuImage(this.source,{
    this.isImageEvenWithServer = false,
    this.image
  });
  
  Future<ImageProvider<dynamic>> loadImageFromSource(String authorization) async {
    if (isImageEvenWithServer || image != null) {
      return image;
    }

    final bytes = await ImagesService.instance.downloadImage(authorization, source);

    if (bytes != null) {
      image = MemoryImage(bytes);
    }

    isImageEvenWithServer = true;
    return image;
  } 
}