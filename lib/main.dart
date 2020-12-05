import 'package:buildup/src/pages/autentication/login_page/login_page.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Build Up',
      theme: ThemeData(
        primaryColor: colorPrimary,
        
        accentColor: colorSecondary,

        cardColor: Colors.white,

        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 48, color: Color(0xff2c3e50)),
          headline2: TextStyle(fontSize: 40, color: Color(0xff2c3e50)),
          headline3: TextStyle(fontSize: 32, color: Color(0xff2c3e50)),
          bodyText2: TextStyle(fontSize: 16),
          button: TextStyle(fontSize: 16)
        )
      ),
      home:LoginPage()
    );
  }
}