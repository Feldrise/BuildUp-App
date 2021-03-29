import 'dart:convert';
import 'dart:io';

import 'package:buildup/entities/user.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

class UsersService {
  UsersService._privateConstructor();

  final String serviceBaseUrl = "$kApiBaseUrl/users";

  static final UsersService instance = UsersService._privateConstructor();

  Future notifyAll(String authorization, String content) async {
    final http.Response response = await http.post(
      Uri.parse('$serviceBaseUrl/notify/all'),
      headers: <String, String> {
        HttpHeaders.authorizationHeader: authorization,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "content": content
      })
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: "Impossible to notify users : ${response.body}");
    }
  }

  // PUT
  Future updateUser(String authorization, User toUpdate) async {
    final http.Response response = await http.put(
      Uri.parse('$serviceBaseUrl/${toUpdate.id}/update'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(toUpdate.toJson())
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }
}