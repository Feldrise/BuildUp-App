import 'dart:convert';
import 'dart:io';

import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/forms/bu_form.dart';
import 'package:buildup/entities/project.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

class BuildersService {
  BuildersService._privateConstructor();

  final String serviceBaseUrl = "$kApiBaseUrl/builders";

  static final BuildersService instance = BuildersService._privateConstructor();

  // GET
  Future<List<BuBuilder>> getCandidatingBuilders(String authorization) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/candidating',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonBuilders = jsonDecode(response.body) as List<dynamic>;
      final List<BuBuilder> builders = [];

      for (final map in jsonBuilders) {
        final User associatedUser = await getUserForBuilder(authorization, map['id'] as String);
        final Project associatedProject = await getProjectForBuilder(authorization, map['id'] as String);
        final BuForm associatedForm = await getFormForBuilder(authorization, map['id'] as String);

        builders.add(BuBuilder.fromMap(map as Map<String, dynamic>, associatedUser: associatedUser, associatedForm: associatedForm));
        builders.last.associatedProjects.add(associatedProject);
      }

      return builders;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<List<BuBuilder>> getActiveBuilders(String authorization) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/active',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonBuilders = jsonDecode(response.body) as List<dynamic>;
      final List<BuBuilder> builders = [];

      for (final map in jsonBuilders) {
        final User associatedUser = await getUserForBuilder(authorization, map['id'] as String);
        final Project associatedProject = await getProjectForBuilder(authorization, map['id'] as String);
        final BuForm associatedForm = await getFormForBuilder(authorization, map['id'] as String);

        builders.add(BuBuilder.fromMap(map as Map<String, dynamic>, associatedUser: associatedUser, associatedForm: associatedForm));
        builders.last.associatedProjects.add(associatedProject);
      }

      return builders;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<User> getUserForBuilder(String authorization, String builderId) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/$builderId/user',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      return User.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<Project> getProjectForBuilder(String authorization, String builderId) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/$builderId/project',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      return Project.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<BuForm> getFormForBuilder(String authorization, String builderId) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/$builderId/form',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      return BuForm.fromList(jsonDecode(response.body) as List<dynamic>);
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  // PUT
  Future updateBuilder(String authorization, BuBuilder toUpdate) async {
    final http.Response response = await http.put(
      '$serviceBaseUrl/${toUpdate.id}/update',
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

  Future refuseBuilder(String authorization, String builderId) async {
    final http.Response response = await http.put(
      '$serviceBaseUrl/$builderId/refuse',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }

}