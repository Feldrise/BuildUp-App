mixin UserRoles {
  static const String admin = "Admin";
  static const String builder = "Builder";
  static const String coach = "Coach";
}

class User {
  final String id;

  final String firstName;
  final String lastName;
  final DateTime birthdate;

  final String email;
  final String discordTag;
  final String username;

  final String role;
  final String token;

  String get authentificationHeader => "Bearer $token";

  User(this.id, {
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
    firstName = map['firstName'] as String,
    lastName = map['lastName'] as String,
    birthdate = DateTime.tryParse(map['birthdate'] as String),

    email = map['email'] as String,
    discordTag = map['discordTag'] as String,
    username = map['username'] as String,

    role = map['role'] as String,
    token = map['token'] as String;

}