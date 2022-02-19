import 'package:flutter/rendering.dart';

extension ColorExtension on Color {
  Color darken({int percent = 10}) {
    assert(1 <= percent && percent <= 100);

    final f = 1 - percent / 100;

    return Color.fromARGB(
      alpha, 
      (red * f).round(), 
      (green * f).round(), 
      (blue * f).round()
    );
  }

  Color brighten({int percent = 10}) {
    assert(1 <= percent && percent <= 100);

    final p = percent / 100;

    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round()
    );
  }

  bool isDark() {
    final double relativeLuminance = computeLuminance();

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
}