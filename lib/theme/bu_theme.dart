import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuTheme {
  static ThemeData theme(BuildContext context) {
    return ThemeData(
      // Colors
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: colorSwatch(Palette.colorPrimary.value),

        accentColor: Palette.colorPrimary,
        backgroundColor: Palette.colorLightGrey1,
        cardColor: Palette.colorWhite,
        errorColor: Palette.colorError,
      ),

      primaryColor: Palette.colorPrimary,
      cardColor: Palette.colorWhite,
      errorColor: Palette.colorError,
      scaffoldBackgroundColor: Palette.colorLightGrey1,
      dividerColor: Palette.colorDivider,

      // Text
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 48, fontWeight: FontWeight.w300, color: Palette.colorTextBlack),
        headline2: TextStyle(fontSize: 40, fontWeight: FontWeight.w300, color: Palette.colorTextBlack),
        headline3: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: Palette.colorTextBlack),
        headline4: TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: Palette.colorTextBlack),
        headline5: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, color: Palette.colorTextBlack),
        headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Palette.colorTextBlack),
        bodyText2: TextStyle(fontSize: 16, color: Palette.colorTextBlack),
        caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Palette.colorIconsBlack),
        button: TextStyle(fontSize: 16),
      ),

      // The appbar theme
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        toolbarHeight: 77,

        backgroundColor: Palette.colorWhite,
        foregroundColor: Palette.colorTextBlack,
        titleTextStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.w300, color: Palette.colorTextBlack),
      ),

      // Default button style
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // Colors 
          primary: Palette.colorPrimary,
          onPrimary: Palette.colorWhite,

          // Style
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 22,
          )
        )
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
        )
      ),

      visualDensity: VisualDensity.standard
    );

  } 
  static ThemeData themeDark(BuildContext context) {
    return ThemeData(
      // Colors
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: colorSwatch(Palette.colorPrimary.value),

        accentColor: Palette.colorPrimary,
        backgroundColor: Palette.colorGrey900,
        cardColor: Palette.colorGrey700,
        errorColor: Palette.colorError,
      ),

      primaryColor: Palette.colorPrimary,
      cardColor: Palette.colorGrey700,
      errorColor: Palette.colorError,
      scaffoldBackgroundColor: Palette.colorGrey900,
      dividerColor: Palette.colorDividerDark,

      // Text
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 48, fontWeight: FontWeight.w300, color: Palette.colorTextWhite),
        headline2: TextStyle(fontSize: 40, fontWeight: FontWeight.w300, color: Palette.colorTextWhite),
        headline3: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: Palette.colorTextWhite),
        headline4: TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: Palette.colorTextWhite),
        headline5: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, color: Palette.colorTextWhite),
        headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Palette.colorTextWhite),
        bodyText2: TextStyle(fontSize: 16, color: Palette.colorTextWhite),
        caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Palette.colorIconsWhite),
        button: TextStyle(fontSize: 16),
      ),

      // The appbar theme
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        toolbarHeight: 77,

        backgroundColor: Palette.colorGrey700,
        foregroundColor: Palette.colorTextWhite,
        titleTextStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.w300, color: Palette.colorTextWhite),
      ),

      // Default button style
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // Colors 
          primary: Palette.colorPrimary,
          onPrimary: Palette.colorWhite,

          // Style
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 22,
          )
        )
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Palette.colorPrimary),
            borderRadius: BorderRadius.circular(60.0),
          ),
        )
      ),

      visualDensity: VisualDensity.standard
    );
  }

  static AppBarTheme themeSecondAppBar(BuildContext context) {
    return const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      toolbarHeight: 77,

      backgroundColor: Palette.colorWhite,
      foregroundColor: Palette.colorTextBlack,
      titleTextStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, color: Palette.colorTextBlack),
    ); 
  }

   static AppBarTheme themeSecondAppBarDark(BuildContext context) {
    return const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      toolbarHeight: 77,

      backgroundColor: Palette.colorGrey700,
      foregroundColor: Palette.colorTextWhite,
      titleTextStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, color: Palette.colorTextWhite),
    ); 
  }
  
  // static ElevatedButtonThemeData themeButtonSecondary(BuildContext context, {
  //   bool coloredBorder = false
  // }) {
  //   return ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //       // Colors
  //       primary: Theme.of(context).scaffoldBackgroundColor,
  //       onPrimary: Theme.of(context).textTheme.bodyText2!.color,

  //       // style
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(60.0),
  //         side: BorderSide(
  //           color: coloredBorder ? Theme.of(context).primaryColor : const Color(0xffefefef)
  //         ),
  //       ),
  //       elevation: 0
  //     )
  //   );
  // }

  static MaterialColor colorSwatch(int value) {
    final color50 = Color(value).withOpacity(0.1);
    final color100 = Color(value).withOpacity(0.2);
    final color200 = Color(value).withOpacity(0.3);
    final color300 = Color(value).withOpacity(0.4);
    final color400 = Color(value).withOpacity(0.5);
    final color500 = Color(value).withOpacity(0.6);
    final color600 = Color(value).withOpacity(0.7);
    final color700 = Color(value).withOpacity(0.8);
    final color800 = Color(value).withOpacity(0.8);
    final color900 = Color(value).withOpacity(1);

    return MaterialColor(value, <int, Color>{
      50:color50,
      100:color100,
      200:color200,
      300:color300,
      400:color400,
      500:color500,
      600:color600,
      700:color700,
      800:color800,
      900:color900,
    });
  }
}