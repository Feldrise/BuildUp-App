import 'package:buildup/entities/bu_image.dart';
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

  Future logout() async {
    await AuthenticationService.instance.logout();
    _user = null;

    notifyListeners();
  }

  String get id => _user.id;
  String get authentificationHeader => _user.authentificationHeader;

  String get fullName => _user.fullName;
  String get firstName => _user.firstName;
  String get lastName => _user.lastName;
  DateTime get birthdate => _user.birthdate;

  BuImage get profilePicture => _user.profilePicture;

  String get email => _user.email;
  String get discordTag => _user.discordTag;
  String get username => _user.username;

  String get role => _user.role;
}