import 'package:flutter/material.dart';

const Color colorPrimary = Color(0xffd43744);
const Color colorSecondary = Color(0xff5caad5);
const Color colorScaffolddWhite = Color(0xffffffff);
const Color colorScaffoldGrey = Color(0xfff5f5f6);

const Color colorBlack = Color(0xff2c3e50);
const Color colorYellow = Color(0xfff4bd2a);

const Color colorSuccess = Color(0xffd4edda);
const Color colorBorderSuccess = Color(0xffc2e5ca);
const Color colorTextSuccess = Color(0xff155724);

const Color colorError = Color(0xfff8d7da);
const Color colorBorderError = Color(0xfff4c2c7);
const Color colorTextError = Color(0xff721c24);

const Color colorInfo = Color(0xffd1ecf1);
const Color colorBorderInfo = Color(0xffbde4eb);
const Color colorTextInfo = Color(0xff0c5460);

const Color colorGreyBackground = Color(0xffebeced);

Color darkenColor(Color c, {int percent = 10}) {
    assert(1 <= percent && percent <= 100);
    
    final f = 1 - percent / 100;
    
    return Color.fromARGB(
        c.alpha,
        (c.red * f).round(),
        (c.green  * f).round(),
        (c.blue * f).round()
    );
}

Color brightenColor(Color c, {int percent = 10}) {
    assert(1 <= percent && percent <= 100);
    
    final  p = percent / 100;
    
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round()
    );
}

/// See https://api.flutter.dev/flutter/material/ThemeData/estimateBrightnessForColor.html
bool colorIsDark(Color color) {
  final double relativeLuminance = color.computeLuminance();

  // See <https://www.w3.org/TR/WCAG20/#contrast-ratiodef>
  // The spec says to use kThreshold=0.0525, but Material Design appears to bias
  // more towards using light text than WCAG20 recommends. Material Design spec
  // doesn't say what value to use, but 0.15 seemed close to what the Material
  // Design spec shows for its color palette on
  // <https://material.io/go/design-theming#color-color-palette>.
  const double kThreshold = 0.15;
  if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold) {
    return false;
  }

  return true;
}