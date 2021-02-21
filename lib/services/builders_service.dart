import 'dart:convert';
import 'dart:io';

import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/buildons/buildon_returning.dart';
import 'package:buildup/entities/coach.dart';
import 'package:buildup/entities/forms/bu_form.dart';
import 'package:buildup/entities/meeting_report.dart';
import 'package:buildup/entities/notification/builder_notification.dart';
import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/entities/project.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/buildons_service.dart';
import 'package:buildup/services/coachs_services.dart';
import 'package:buildup/services/ntf_referents_service.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

class BuildersService {
  BuildersService._privateConstructor();

  final String serviceBaseUrl = "$kApiBaseUrl/builders";

  static final BuildersService instance = BuildersService._privateConstructor();

  // GET
  Future<BuBuilder> getBuilder(String authorization, String currentUserRole, User associatedUser) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/${associatedUser.id}',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      final Project associatedProject = await getProjectForBuilder(authorization, currentUserRole, map['id'] as String);
      final List<MeetingReport> associatedMeetingReports = await getMeetingReportsForBuilder(authorization, map['id'] as String);
      final BuForm associatedForm = await getFormForBuilder(authorization, map['id'] as String);
      final Coach associatedCoach = await getCoachForBuilder(authorization, map['coachId'] as String, map['id'] as String);
      final NtfReferent associatedNtfReferent = await NtfReferentsService.instance.getReferent(authorization, map['ntfReferentId'] as String);

      final List<BuilderNotification> builderNotifications = await getBuilderNotifications(authorization, map['id'] as String);
      
      final BuBuilder builder = BuBuilder.fromMap(map, associatedUser: associatedUser, associatedMeetingReports: associatedMeetingReports, associatedForm: associatedForm, associatedCoach: associatedCoach, associatedNtfReferent: associatedNtfReferent, associatedNotifications: builderNotifications);
      builder.associatedProjects.add(associatedProject);

      return builder;
    }

    throw PlatformException(code: response.statusCode.toString(), message: "Error getting the builder: ${response.body}");

  }

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
        final Project associatedProject = await getProjectForBuilder(authorization, UserRoles.admin, map['id'] as String);
        final List<MeetingReport> associatedMeetingReports = await getMeetingReportsForBuilder(authorization, map['id'] as String);
        final BuForm associatedForm = await getFormForBuilder(authorization, map['id'] as String);

        builders.add(BuBuilder.fromMap(map as Map<String, dynamic>, associatedUser: associatedUser, associatedMeetingReports: associatedMeetingReports, associatedForm: associatedForm));
        builders.last.associatedProjects.add(associatedProject);
      }

      return builders;
    }

    throw PlatformException(code: response.statusCode.toString(), message: "Error getting candidating builders: ${response.body}");
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
        final Project associatedProject = await getProjectForBuilder(authorization, UserRoles.admin, map['id'] as String);
        final List<MeetingReport> associatedMeetingReports = await getMeetingReportsForBuilder(authorization, map['id'] as String);
        final BuForm associatedForm = await getFormForBuilder(authorization, map['id'] as String);
        final Coach associatedCoach = await getCoachForBuilder(authorization, map['coachId'] as String, map['id'] as String);
        final NtfReferent associatedNtfReferent = await NtfReferentsService.instance.getReferent(authorization, map['ntfReferentId'] as String);

        builders.add(BuBuilder.fromMap(map as Map<String, dynamic>, associatedUser: associatedUser, associatedMeetingReports: associatedMeetingReports, associatedForm: associatedForm, associatedCoach: associatedCoach, associatedNtfReferent: associatedNtfReferent));
        builders.last.associatedProjects.add(associatedProject);
      }

      return builders;
    }

    throw PlatformException(code: response.statusCode.toString(), message: "Error getting active builders: ${response.body}");
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

    throw PlatformException(code: response.statusCode.toString(), message: "Error getting the user for the builder: ${response.body}");
  }

  
  Future<Coach> getCoachForBuilder(String authorization, String coachId, String builderId) async {
    if (coachId == null) {
      return null;
    }

    final http.Response response = await http.get(
      '$serviceBaseUrl/$builderId/coach',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final User coachUser = await CoachsService.instance.getUserForCoach(authorization, coachId);
      
      return Coach.fromMap(jsonDecode(response.body) as Map<String, dynamic>, associatedForm: null, associatedUser: coachUser);
    }

    if (response.statusCode == 404) {
      return null;
    }

    throw PlatformException(code: response.statusCode.toString(), message: "Error getting the coach for the builder: ${response.body}");
  }

  Future<Project> getProjectForBuilder(String authorization, String currentUserRole, String builderId) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/$builderId/project',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;

      final List<BuildOnReturning> buildOnReturningsList = await BuildOnsService.instance.getReturningsForProject(authorization, json['id'] as String);      
      final Map<String, BuildOnReturning> buildOnReturnings = {};
      bool hasNotification = false;

      for (final returning in buildOnReturningsList) {
        if (returning.status == BuildOnReturningStatus.refused) {
          continue;
        }

        if (returning.status == BuildOnReturningStatus.waiting && currentUserRole != UserRoles.builder ||
            returning.status == BuildOnReturningStatus.waitingCoach && currentUserRole == UserRoles.coach ||
            returning.status == BuildOnReturningStatus.waitingAdmin && currentUserRole == UserRoles.admin) {
          hasNotification = true;
        }

        buildOnReturnings[returning.buildOnStepId] = returning;
      }

      return Project.fromMap(json, associatedReturnings: buildOnReturnings, hasNotification: hasNotification);
    }

    throw PlatformException(code: response.statusCode.toString(), message: "Error getting the project for the builder: ${response.body}");
  }

  Future<List<MeetingReport>> getMeetingReportsForBuilder(String authorization, String builderId) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/$builderId/meeting_reports',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonMeetingReports = jsonDecode(response.body) as List<dynamic>;
      final List<MeetingReport> meetingReports = [];

      for (final map in jsonMeetingReports) {
        meetingReports.add(MeetingReport.fromMap(map as Map<String, dynamic>));
      }

      return meetingReports;
    }

    throw PlatformException(code: response.statusCode.toString(), message: "Error getting meeting reports for the builder: ${response.body}");
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

    throw PlatformException(code: response.statusCode.toString(), message: "Error getting form for builder: ${response.body}");
  }

  Future<List<BuilderNotification>> getBuilderNotifications(String authorization, String builderId) async {
    final http.Response response = await http.get(
      '$serviceBaseUrl/$builderId/notifications',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonNotifications = jsonDecode(response.body) as List<dynamic>;
      final List<BuilderNotification> notifications = [];

      for (final map in jsonNotifications) {
        notifications.add(BuilderNotification.fromMap(map as Map<String, dynamic>));
      }

      return notifications;
    }

    throw PlatformException(code: response.statusCode.toString(), message: "Failed to get builder notifications: ${response.body}");
  }

  // POST
  Future assignCoach(String authorization, BuBuilder toUpdate, String coachId) async {
    final http.Response response = await http.post(
      '$serviceBaseUrl/${toUpdate.id}/assign',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "coachId": coachId
      })
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }
  
  Future<String> createMeetingReport(String authorization, String builderId, MeetingReport toCreate) async {
    final http.Response response = await http.post(
      '$serviceBaseUrl/$builderId/meeting_reports',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(toCreate.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    
    throw Exception("Impossible to create the meeting report: ${response.body}");
  }

  // PUT
  Future signIntegration(String authorization, String builderId) async {
    final http.Response response = await http.put(
      '$serviceBaseUrl/$builderId/sign_integration',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }

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

  
  Future updateProject(String authorization, BuBuilder toUpdate) async {
    final http.Response response = await http.put(
      '$serviceBaseUrl/${toUpdate.id}/projects/${toUpdate.associatedProjects.first.id}/update',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(toUpdate.associatedProjects.first.toJson())
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }

  Future markNotificationAsRead(String authorization, String builderId, String notificationId) async {
    final http.Response response = await http.put(
      '$serviceBaseUrl/$builderId/notifications/$notificationId/read',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authorization,
      },
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: "Error marking the notification as read: ${response.body}");
    }
  }

}