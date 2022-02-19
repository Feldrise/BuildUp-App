import 'package:buildup/features/authentication/app_user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Init {
  Init._();

  static final instance = Init._();

  Future initialize(GraphQLClient client, WidgetRef ref) async {
    await ref.read(appUserControllerProvider.notifier).initializeUser(client);
  }

  
}