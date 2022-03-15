import 'package:flutter/cupertino.dart';

class AppManager {
  AppManager._();

  static final AppManager instance = AppManager._();

  final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

  // ADMIN KEYS
  final GlobalKey<NavigatorState> adminActiveMembersKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> adminBuildOnEditKey = GlobalKey<NavigatorState>();

  // COACHS KEYS
  final GlobalKey<NavigatorState> coachBuildersKey = GlobalKey<NavigatorState>();

  // GENERIC KEYS
  final GlobalKey<NavigatorState> buildOnsKey = GlobalKey<NavigatorState>();
}