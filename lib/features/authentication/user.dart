import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

mixin UserRoles {
  static const String admin = "ADMIN";
  static const String builder = "BUILDER";
  static const String coach = "COACH";

  static const Map<String, String> detailled = {
    admin: "Equipe New Talents",
    builder: "Builder",
    coach: "Coach"
  };
}


@immutable
@freezed
class User with _$User {
  const factory User({
    required String firstName,
    required String lastName,
    required String role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}