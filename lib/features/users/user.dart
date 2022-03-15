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

mixin UserStatus {
  static const String unknown = "UNKNOWN";
  static const String candidating = "CANDIDATING";
  static const String validated = "VALIDATED";
  static const String deleted = "REFUSED";

  static const Map<String, String> detailled = {
    unknown: "Inconnue",
    candidating: "En attente",
    validated: "Validée",
    deleted: "Refusée"
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
    required String description,
    @Default("UNKNOWN") String status,
    @Default("UNKNOWN") String step,
    @Default("Situation Inconnue") String situation,
    DateTime? createdAt,
    DateTime? birthdate,
    String? address,
    String? discord,
    String? linkedin,
    BuBuilder? builder,
    Coach? coach,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}