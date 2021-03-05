import 'package:flutter/material.dart';

class AppManager {
  AppManager._privateConstructor();

  static final AppManager instance = AppManager._privateConstructor();

  // REGISTER ALL NAVIGATORS HERE 
  final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> adminActiveBuilderKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> adminActiveCoachKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> adminActiveKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> adminBuildUpKey = GlobalKey<NavigatorState>();
  
  final GlobalKey<NavigatorState> builderProfilKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> builderProjectKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> builderBuildOnsKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> coachBuilderKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> coachBuildersKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> coachProfileKey = GlobalKey<NavigatorState>();

  // Because we are calling this from the main widget we have to check
  // nested navigators status.
  Future<bool> showCloseAppConfirmation(BuildContext context) {
    // Check a Lower Navigator First
    if (coachProfileKey.currentState.canPop()) {
      coachProfileKey.currentState.pop();
      return Future.value(false);
    }

    if (coachBuilderKey.currentState.canPop()) {
      coachBuilderKey.currentState.pop();
      return Future.value(false);
    }

    if (builderProfilKey.currentState.canPop()) {
      builderProfilKey.currentState.pop();
      return Future.value(false);
    }

    if (builderProjectKey.currentState.canPop()) {
      builderProjectKey.currentState.pop();
      return Future.value(false);
    }

    if (coachBuildersKey.currentState.canPop()) {
      coachBuildersKey.currentState.pop();
      return Future.value(false);
    }

    if (adminActiveBuilderKey.currentState.canPop()) {
      adminActiveBuilderKey.currentState.pop();
      return Future.value(false);
    }

    if (adminActiveCoachKey.currentState.canPop()) {
      adminActiveCoachKey.currentState.pop();
      return Future.value(false);
    }

    if (adminBuildUpKey.currentState.canPop()) {
      adminBuildUpKey.currentState.pop();
      return Future.value(false);
    }

    if (adminActiveKey.currentState.canPop()) {
      adminActiveKey.currentState.pop();
      return Future.value(false);
    }

    if (builderBuildOnsKey.currentState.canPop()) {
      builderBuildOnsKey.currentState.pop();
      return Future.value(false);
    }

    // Check current context navigator Main App Navigator
    if (appNavigatorKey.currentState.canPop()) {
      appNavigatorKey.currentState.pop();
      return Future.value(false);
    }

    // SHOW CLOSE APP CONFIRMATION DIALOG
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text("Etes vous sur de vouloir quitter l'application ?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Oui'),
          ),
        ],
      ),
    );
  }
}