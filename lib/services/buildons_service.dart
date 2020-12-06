import 'dart:convert';
import 'dart:io';

import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class BuildOnsService {
  BuildOnsService._privateConstructor();

  final String serviceBaseUrl = "https://192.168.1.19:45455/buildup/buildons";

  static final BuildOnsService instance = BuildOnsService._privateConstructor();

  // GET
  Future<List<BuildOn>> getAllBuildOns(String authorization) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    return [
      BuildOn()
        ..name = "Test 1"
        ..description = "Description Test 1",
      BuildOn()
        ..name = "Test 2"
        ..description = "Description Test 2",
      BuildOn()
        ..name = "Test 3"
        ..description = "Description Test 3",
      BuildOn()
        ..name = "Test 4"
        ..description = "Description Test 4"
    ];
    // final http.Response response = await http.get(
    //   serviceBaseUrl,
    //   headers: <String, String>{
    //     HttpHeaders.authorizationHeader: authorization,
    //   },
    // );

    // if (response.statusCode == 200) {
    //   final List<dynamic> jsonBuildOns = jsonDecode(response.body) as List<dynamic>;
    //   final List<BuildOn> buildOns = [];

    //   for (final map in jsonBuildOns) {
    //     final List<BuildOnStep> steps = await getBuildOnSteps(authorization, map['id'] as String);

    //     buildOns.add(BuildOn.fromMap(map as Map<String, dynamic>, steps: steps));
    //   }

    //   return buildOns;
    // }

    // throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<List<BuildOnStep>> getBuildOnSteps(String authorization, String buildOnId) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/$buildOnId/steps',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonBuildOnSteps = jsonDecode(response.body) as List<dynamic>;
      final List<BuildOnStep> buildOnSteps = [];

      for (final map in jsonBuildOnSteps) {
        buildOnSteps.add(BuildOnStep.fromMap(map as Map<String, dynamic>));
      }

      return buildOnSteps;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

}