import 'dart:convert';

import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/users_service.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  AuthenticationService._privateConstructor();

  final String serviceBaseUrl = "$kApiBaseUrl/authentication";

  static final AuthenticationService instance = AuthenticationService._privateConstructor();

  Future<User> getLoggedUser() {
    return _getUserFromSettings();
  }

  Future<User> login(String username, String password, {bool remember = false}) async {
    final http.Response response = await http.post(
      '$serviceBaseUrl/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password
      })
    );

    if (response.statusCode == 200) {
      final User loggedUser = User.fromMap(jsonDecode(response.body) as Map<String, dynamic>);

      if (remember) {
        await _saveUserToSettings(loggedUser);
      }

      return loggedUser;
    }

    throw PlatformException(code: response.statusCode.toString(), message: "Impossible de se connecter : ${response.body}");
  }

  Future logout() async {
    await _saveUserToSettings(null);
  }

  Future _saveUserToSettings(User toSave) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString("user_id", toSave?.id);
    
    await preferences.setString("user_firstName", toSave?.firstName);
    await preferences.setString("user_lastName", toSave?.lastName);
    await preferences.setString("user_birthdate", toSave?.birthdate?.toIso8601String());

    await preferences.setString("user_email", toSave?.email);
    await preferences.setString("user_discordTag", toSave?.discordTag);
    await preferences.setString("user_username", toSave?.username);

    await preferences.setInt("user_department", toSave?.department);

    await preferences.setString("user_role", toSave?.role);
    await preferences.setString("user_token", toSave?.token);
  }

  Future<User> _getUserFromSettings() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final String id = preferences.getString("user_id");
    
    if (id == null) { return null; }
    
    final User user = User(
      preferences.getString("user_id"),
      firstName:  preferences.getString("user_firstName" ?? ""),
      lastName: preferences.getString("user_lastName" ?? ""),
      birthdate: DateTime.tryParse(preferences.getString("user_birthdate" ?? "")),
      email: preferences.getString("user_email" ?? ""),
      discordTag: preferences.getString("user_discordTag" ?? ""),
      username: preferences.getString("user_username" ?? ""),
      department: preferences.getInt("user_department"), 
      role: preferences.getString("user_role" ?? ""), 
      token: preferences.getString("user_token" ?? "")
    );

    user.profilePicture = BuImage("${UsersService.instance.serviceBaseUrl}/${user.id}/profile_picture");

    return user;
  }
}