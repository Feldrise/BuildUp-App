import 'package:buildup/features/authentication/app_user_state.dart';
import 'package:buildup/features/authentication/authentication_graphql.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final appUserControllerProvider = StateNotifierProvider<AppUserController, AppUserState>((ref) {
  return AppUserController(
    const AppUserState()
  );
});

class AppUserController extends StateController<AppUserState> {
  AppUserController(AppUserState state) : super(state);

  Future initializeUser(GraphQLClient client) async {
    String? token = state.token;

    if (token != null) return;

    const storage = FlutterSecureStorage();

    // We need to check if the user already logged in
    final String? username = await storage.read(key: 'user_username');
    final String? password = await storage.read(key: 'user_password');

    if (username == null || password == null) return;

    // Now we can login
    final MutationOptions options = MutationOptions<dynamic>(
      document: gql(qMutAuthenticationLogin),
      variables: <String, dynamic>{
        "email": username,
        "password": password
      }
    );
    final QueryResult result = await client.mutate<dynamic>(options);

    if (result.hasException) return;

    token = result.data!['login'] as String?;

    state = state.copyWith(
      token: token
    );
  }

  void loginUser(String token) {
    state = state.copyWith(
      token: token
    );
  }
}