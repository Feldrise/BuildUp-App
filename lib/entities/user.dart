import 'package:buildup/entities/bu_image.dart';

mixin UserRoles {
  static const String admin = "Admin";
  static const String builder = "Builder";
  static const String coach = "Coach";
}

class User {
  final String id;

  BuImage profilePicture;

  String firstName;
  String lastName;
  DateTime birthdate;

  String email;
  String discordTag;
  String username;

  String role;
  String token;

  String get fullName =>  "$firstName $lastName";
  String get authentificationHeader => "Bearer $token";

  User(this.id, {
    this.profilePicture,
    this.firstName,
    this.lastName,
    this.birthdate,
    this.email,
    this.discordTag,
    this.username,
    this.role,
    this.token
  });

  User.fromMap(Map<String, dynamic> map) : 
    id = map['id'] as String,
    image = BuImage("${BuildOnsService.instance.serviceBaseUrl}/steps/${map['id'] as String}/image"),
    firstName = map['firstName'] as String,
    lastName = map['lastName'] as String,
    birthdate = DateTime.tryParse(map['birthdate'] as String),

    email = map['email'] as String,
    discordTag = map['discordTag'] as String,
    username = map['username'] as String,

    role = map['role'] as String,
    token = map['token'] as String;

}