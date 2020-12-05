import 'package:buildup/entities/user.dart';
import 'package:buildup/services/authentication_service.dart';
import 'package:flutter/material.dart';

class UserStore with ChangeNotifier {
  User _user;

  Future<User> get loggedUser async {
    return _user ??= await AuthenticationService.instance.getLoggedUser();
  }

  void loginUser(User loggedUser) {
    _user = loggedUser;

    notifyListeners();
  }

  String get id => _user.id;
  String get authentificationHeader => _user.authentificationHeader;

  String get fullName => "${_user.firstName} ${_user.lastName}";
  String get firstName => _user.firstName;
  String get lastName => _user.lastName;
  DateTime get birthdate => _user.birthdate;

  String get email => _user.email;
  String get discordTag => _user.discordTag;
  String get username => _user.username;

  String get role => _user.role;
}