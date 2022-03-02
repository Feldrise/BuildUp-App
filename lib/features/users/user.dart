import 'package:buildup/features/builders/bu_builder.dart';
import 'package:buildup/features/coachs/coach.dart';
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
  const factory User(String? id, {
    required String email,
    required String firstName,
    required String lastName,
    required String role,
    required String step,
    required String description,
    @Default("Situation Inconnue") String situation,
    DateTime? createdAt,
    DateTime? birthday,
    String? address,
    String? discord,
    String? linkedin,
    BuBuilder? builder,
    Coach? coach,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}