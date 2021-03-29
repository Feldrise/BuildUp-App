import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ImagesService {
  ImagesService._privateConstructor();

  static final ImagesService instance = ImagesService._privateConstructor();

  // GET
  Future<Uint8List?> downloadImage(String authorization, String source) async {
    final http.Response response = await http.get(
      Uri.parse(source),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      return base64Decode(jsonDecode(response.body) as String);
    }
    
    return null;
  }
}