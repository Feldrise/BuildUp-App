import 'package:buildup/core/graphql/graphql_client.dart';
import 'package:buildup/core/utils/init.dart';
import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/splash_screen.dart';
import 'package:buildup/features/authentication/app_user_controller.dart';
import 'package:buildup/features/authentication/authentication_page.dart';
import 'package:buildup/features/authentication/user.dart';
import 'package:buildup/features/main_page/main_page.dart';
import 'package:buildup/theme/bu_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter(); // For GraphQL cache
  await HiveStore.openBox<dynamic>(HiveStore.defaultBoxName);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? token = ref.watch(appUserControllerProvider).token;
    
    return MaterialApp(
      title: 'BuildUp',
      theme: BuTheme.theme(context),
      home: GraphQLProvider(
        client: graphQLClient(token),
        child: GraphQLConsumer(
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
        
              return const MainPage();
            },
          ),
        ),
      ),
    );
  }
}