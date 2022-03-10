import 'package:buildup/core/graphql/graphql_client.dart';
import 'package:buildup/core/utils/app_manager.dart';
import 'package:buildup/core/utils/init.dart';
import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/core/widgets/splash_screen.dart';
import 'package:buildup/features/authentication/app_user_controller.dart';
import 'package:buildup/features/authentication/authentication_graphql.dart';
import 'package:buildup/features/authentication/authentication_page.dart';
import 'package:buildup/features/main_page/builder_main_page.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/main_page/admin_main_page.dart';
import 'package:buildup/theme/bu_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter(); // For GraphQL cache
  await HiveStore.openBox<dynamic>(HiveStore.defaultBoxName);

  // TODO: DEBUG ONLY
  // const storage = FlutterSecureStorage();
  // await storage.delete(key: "user_username");
  // await storage.delete(key: "user_password");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? token = ref.watch(appUserControllerProvider).token;
    
    return GraphQLProvider(
      client: graphQLClient(token),
      child: MaterialApp(
        title: 'BuildUp',
        navigatorKey: AppManager.instance.appNavigatorKey,
        theme: BuTheme.theme(context),
        home: GraphQLConsumer(
          builder: (client) => FutureBuilder<dynamic>(
            future: Init.instance.initialize(client, ref),
            builder: (context, snapshot) {
              ScreenUtils.instance.setValues(context);
    
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
        
              token = ref.read(appUserControllerProvider).token;
              if (token == null) {
                return const AuthenticationPage();
              }
        
              // We need the user role
              return Query<dynamic>(
                options: QueryOptions<dynamic>(
                  document: gql(qGetLoggedUser),
                ),
                builder: (result, {fetchMore, refetch}) {
                  final User appUser = User.fromJson(result.data?["user"] as Map<String, dynamic>? ?? <String, dynamic>{});
    
                  if (appUser.role == UserRoles.admin) {
                    return const AdminMainPage();
                  }
    
                  if (appUser.role == UserRoles.builder) {
                    return const BuilderMainPage();
                  }

                  return const BuStatusMessage(
                    type: BuStatusMessageType.info,
                    message: "Il semblerais que votre rôle ne soit pas reconnu. Vous n'auriez jamais du voir ce message, veuillez contacter notre équipe !",
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}