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

  User get user => _user;

  String get id => _user.id;
  String get authentificationHeader => _user.authentificationHeader;

}