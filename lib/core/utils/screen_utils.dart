import 'package:flutter/cupertino.dart';

class ScreenUtils {
  ScreenUtils._privateConstructor();

  static final ScreenUtils instance = ScreenUtils._privateConstructor();

  double horizontalPadding = 15;

  int breakpointPC = 768;
  int breakpointTablet = 481;
  
  void setValues(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > breakpointPC) {
      horizontalPadding = 32;
    }
    else if (width > breakpointTablet) {
      horizontalPadding = 24;
    }
  }
}