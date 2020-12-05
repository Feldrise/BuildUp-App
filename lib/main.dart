import 'dart:io';

import 'package:buildup/entities/user.dart';
import 'package:buildup/src/pages/administration/admin_main_page/admib_main_page.dart';
import 'package:buildup/src/pages/autentication/login_page/login_page.dart';
import 'package:buildup/src/pages/splash_screen/splash_screen.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebugHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = DebugHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserStore(),),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Build Up',
          theme: ThemeData(
            primaryColor: colorPrimary,
            
            accentColor: colorSecondary,

            cardColor: Colors.white,

            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 48, color: colorBlack),
              headline2: TextStyle(fontSize: 40, color: colorBlack),
              headline3: TextStyle(fontSize: 32, color: colorBlack),
              bodyText2: TextStyle(fontSize: 16),
              button: TextStyle(fontSize: 16)
            ),

            appBarTheme: const AppBarTheme(
              brightness: Brightness.light,
              color: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: colorBlack),
              textTheme: TextTheme(
                headline6: TextStyle(color: colorBlack, fontSize: 40)
              )
            ),

            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
            future: Provider.of<UserStore>(context).loggedUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text("Erreur lors du chargement de l'application : ${snapshot.error.toString()}"),);
                }

                if (!snapshot.hasData) {
                  return LoginPage();
                }

                final User loggedUser = snapshot.data as User;

                if (loggedUser.role == UserRoles.admin) {
                  return AdminMainPage();
                }
                else {
                  return const Center(child: Text("Erreur lors du chargement de l'application : vous n'avez pas les permissions nécessaires"),);
                }
              }

              return SplashScreen();
            },
          )
        );
      },
    );
  }
}