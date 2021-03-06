
import 'package:flutter/cupertino.dart';

class ScreenUtils {
  ScreenUtils._privateConstructor();

  static final ScreenUtils instance = ScreenUtils._privateConstructor();

  double horizontalPadding = 15;
  double buttonHorizontalPadding = 36;
  double buttonVerticalPadding = 20;

  int breakpointPC = 768;
  int breakpointTablet = 481;
  
  void setValues(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > breakpointPC) {
      horizontalPadding = 32;
      buttonHorizontalPadding = 51;
      buttonVerticalPadding = 21;
    }
    else if (width > breakpointTablet) {
      horizontalPadding = 24;
      buttonHorizontalPadding = 42;
      buttonVerticalPadding = 21;
    }
  }
}