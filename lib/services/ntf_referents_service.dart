
import 'dart:convert';
import 'dart:io';

import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class NtfReferentsService {
  NtfReferentsService._privateConstructor();

  final String serviceBaseUrl = "$kApiBaseUrl/ntfreferents";

  static final NtfReferentsService instance = NtfReferentsService._privateConstructor();

  //GET 
  Future<List<NtfReferent>> getAllReferents(String authorization) async {
    final http.Response response = await http.get(
      serviceBaseUrl,
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonNtfReferents = jsonDecode(response.body) as List<dynamic>;
      final List<NtfReferent> ntfReferents = [];

      for (final map in jsonNtfReferents) {
        ntfReferents.add(NtfReferent.fromMap(map as Map<String, dynamic>));
      }

      return ntfReferents;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<NtfReferent> getReferent(String authorization, String id) async {
    if (id == null) {
      return null;
    }

    final http.Response response = await http.get(
      "$serviceBaseUrl/$id",
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      return NtfReferent.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
    }

    if (response.statusCode == 404) {
      return null;
    }
    
    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }
}