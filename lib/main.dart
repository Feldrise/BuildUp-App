import 'dart:io';

import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/coach.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/authentication_service.dart';
import 'package:buildup/src/pages/administration/admin_main_page/admin_main_page.dart';
import 'package:buildup/src/pages/autentication/login_page/login_page.dart';
import 'package:buildup/src/pages/builder/builder_main_page/builder_main_page.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_main_page/candidating_process_main_page.dart';
import 'package:buildup/src/pages/coachs/coach_main_page/coach_main_page.dart';
import 'package:buildup/src/pages/splash_screen/splash_screen.dart';
import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/src/providers/buildons_store.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/providers/ntf_referents_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_loading_indicator.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
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
        ChangeNotifierProvider(create: (context) => BuilderStore()),
        ChangeNotifierProvider(create: (context) => CoachStore(),),
        ChangeNotifierProvider(create: (context) => BuildOnsStore(),),
        ChangeNotifierProvider(create: (context) => NtfReferentsStore(),)
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Build Up',
          theme: ThemeData(
            primaryColor: colorPrimary,
            
            accentColor: colorSecondary,

            scaffoldBackgroundColor: colorScaffolddWhite,
            cardColor: Colors.white,

            dividerColor: const Color(0xffefefef),

            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 48, color: colorBlack),
              headline2: TextStyle(fontSize: 40, color: colorBlack),
              headline3: TextStyle(fontSize: 32, color: colorBlack),
              headline4: TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: colorBlack),
              headline5: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: colorBlack),
              headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: colorBlack),
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

            dividerTheme: const DividerThemeData(
              color: Color(0xffedf1f7),
              thickness: 1
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
                  return _buildAdminPage();
                }
                else if (loggedUser.role == UserRoles.builder) {
                  return _buildBuilderPage(context, loggedUser);
                }
                else if (loggedUser.role == UserRoles.coach) {
                  return _buildCoachPage(context, loggedUser);
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

  Widget _buildAdminPage() {
    return AdminMainPage();
  }

  Widget _buildBuilderPage(BuildContext context, User loggedUser) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: Provider.of<BuilderStore>(context).loadBuilderFromUser(loggedUser),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              AuthenticationService.instance.logout();

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: Center(
                  child: BuStatusMessage(
                    title: "Erreur",
                    message: "Erreure lors de la récupération des informations Builder. Veuillez nous le signaler et raffraichir la page (ou redémarrer l'application) pour réessayer : ${snapshot.error}",
                  ),
                ),
              );
            }

            final BuBuilder builder = Provider.of<BuilderStore>(context, listen: false).builder;
            
            if (builder.status == BuilderStatus.candidating ||
                builder.status == BuilderStatus.deleted) {
              return CandidatingProcessMainPage();
            }

            return BuilderMainPage();
          }

          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Center(child: BuLoadingIndicator(message: "Récupération des informations Builder...")),
          );
        },
      ),
    );
  }

  
  Widget _buildCoachPage(BuildContext context, User loggedUser) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: Provider.of<CoachStore>(context).loadCoachFromUser(loggedUser),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              AuthenticationService.instance.logout();

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: Center(
                  child: BuStatusMessage(
                    title: "Erreur",
                    message: "Erreure lors de la récupération des informations Coachs. Veuillez nous le signaler et raffraichir la page (ou redémarrer l'application) pour réessayer : ${snapshot.error}",
                  ),
                ),
              );
            }

            final Coach coach = Provider.of<CoachStore>(context, listen: false).coach;

            if (coach.status == CoachStatus.candidating ||
                coach.status == CoachStatus.deleted) {
              return CandidatingProcessMainPage();
            }

            return CoachMainPage();
          }

          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Center(child: BuLoadingIndicator(message: "Récupération des informations Coach...")),
          );
        },
      ),
    );
  }
}