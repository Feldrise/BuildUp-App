import 'dart:convert';
import 'dart:io';

import 'package:buildup/entities/available_coach.dart';
import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/coach.dart';
import 'package:buildup/entities/forms/bu_form.dart';
import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/entities/project.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:buildup/services/ntf_referents_service.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class CoachsService {
  CoachsService._privateConstructor();

  final String serviceBaseUrl = "$kApiBaseUrl/coachs";

  static final CoachsService instance = CoachsService._privateConstructor();

  // GET
  Future<Coach> getCoach(String authorization, User associatedUser) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/${associatedUser.id}',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      final BuForm associatedForm = await getFormForCoach(authorization, map['id'] as String);

      return Coach.fromMap(map, associatedUser: associatedUser, associatedForm: associatedForm,);
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);

  }

  Future<List<Coach>> getCandidatingCoach(String authorization) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/candidating',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonCoachs = jsonDecode(response.body) as List<dynamic>;
      final List<Coach> coachs = [];

      for (final map in jsonCoachs) {
        final User associatedUser = await getUserForCoach(authorization, map['id'] as String);
        final BuForm associatedForm = await getFormForCoach(authorization, map['id'] as String);

        coachs.add(Coach.fromMap(map as Map<String, dynamic>, associatedUser: associatedUser, associatedForm: associatedForm));
      }

      return coachs;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<List<Coach>> getActiveCoachs(String authorization) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/active',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonCoachs = jsonDecode(response.body) as List<dynamic>;
      final List<Coach> coachs = [];

      for (final map in jsonCoachs) {
        final User associatedUser = await getUserForCoach(authorization, map['id'] as String);
        final BuForm associatedForm = await getFormForCoach(authorization, map['id'] as String);

        coachs.add(Coach.fromMap(map as Map<String, dynamic>, associatedUser: associatedUser, associatedForm: associatedForm));
      }

      return coachs;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  
  Future<List<AvailableCoach>> getAvailableCoachs(String authorization) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/available',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonCoachs = jsonDecode(response.body) as List<dynamic>;
      final List<AvailableCoach> coachs = [];

      for (final map in jsonCoachs) {
        coachs.add(AvailableCoach.fromMap(map as Map<String, dynamic>));
      }

      return coachs;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  
  Future<List<BuBuilder>> getBuildersForCoach(String authorization, Coach coach) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/${coach.id}/builders',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonBuilders = jsonDecode(response.body) as List<dynamic>;
      final List<BuBuilder> builders = [];

      for (final map in jsonBuilders) {
        final User associatedUser = await BuildersService.instance.getUserForBuilder(authorization, map['id'] as String);
        final Project associatedProject = await BuildersService.instance.getProjectForBuilder(authorization, UserRoles.coach, map['id'] as String);
        final BuForm associatedForm = await BuildersService.instance.getFormForBuilder(authorization, map['id'] as String);
        final NtfReferent associatedNtfReferent = await NtfReferentsService.instance.getReferent(authorization, map['ntfReferentId'] as String);

        builders.add(BuBuilder.fromMap(map as Map<String, dynamic>, associatedUser: associatedUser, associatedForm: associatedForm, associatedCoach: coach, associatedNtfReferent: associatedNtfReferent));
        builders.last.associatedProjects.add(associatedProject);
      }

      return builders;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<User> getUserForCoach(String authorization, String coachId) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/$coachId/user',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      return User.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<BuForm> getFormForCoach(String authorization, String coachId) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/$coachId/form',
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
  Future signIntegration(String authorization, String coachId) async {
    final http.Response response = await http.put(
      '$serviceBaseUrl/$coachId/sign_integration',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }


  Future updateCoach(String authorization, Coach toUpdate) async {
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

  Future refuseCoach(String authorization, String coachId) async {
    final http.Response response = await http.put(
      '$serviceBaseUrl/$coachId/refuse',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }

}
