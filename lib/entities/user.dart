import 'dart:convert';

import 'package:buildup/entities/bu_image.dart';
import 'package:buildup/services/users_service.dart';

mixin UserRoles {
  static const String admin = "Admin";
  static const String builder = "Builder";
  static const String coach = "Coach";

  static const Map<String, String> detailled = {
    admin: "Equipe New Talents",
    builder: "Builder",
    coach: "Coach"
  };
}

class User {
  final String id;

  BuImage? profilePicture;

  String firstName;
  String lastName;
  DateTime birthdate;

  String email;
  String? discordTag;
  String username;

  String role;
  String? token;
  
  int department;

  String? newPassword;
  
  String get fullName =>  "$firstName $lastName";
  String get authentificationHeader => "Bearer $token";

  User(this.id, {
    this.profilePicture,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.email,
    this.discordTag,
    required this.department,
    required this.username,
    required this.role,
    this.token
  });

  User.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String,
    profilePicture = BuImage("${UsersService.instance.serviceBaseUrl}/${map['id'] as String}/profile_picture"),
    firstName = map['firstName'] as String,
    lastName = map['lastName'] as String,
    birthdate = DateTime.tryParse(map['birthdate'] as String) ?? DateTime.now(),

    email = map['email'] as String,
    discordTag = map['discordTag'] as String,
    username = map['username'] as String,

    department = map['department'] as int,

    role = map['role'] as String,
    token = map['token'] as String;

  
  Map<String, dynamic> toJson() {
    String? profilePictureString;

    if (profilePicture != null && (!profilePicture!.isImageEvenWithServer && profilePicture!.image != null)) {
      profilePictureString = base64Encode(profilePicture!.image!.bytes);
    }

    return <String, dynamic>{
      "profilePicture": profilePictureString,
      "firstName": firstName,
      "lastName": lastName,
      "birthdate": birthdate.toIso8601String(),
      "email": email,
      "discordTag": discordTag,
      "department": department,
      "password": newPassword
    };
  }
}