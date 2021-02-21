import 'package:flutter/material.dart';

import 'package:buildup/utils/colors.dart';

enum BuButtonType { primary, secondary, secondaryGrey, coloredSecondary, outlineRed, outlineGreen }

class BuButton extends StatelessWidget {
  const BuButton({
    Key key,
    this.icon,
    @required this.text,
    @required this.onPressed,
    this.buttonType = BuButtonType.primary,
    this.isBig = false,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function() onPressed;

  final BuButtonType buttonType;
  final bool isBig;

  @override
  Widget build(BuildContext context) {
    final double verticalBigFactor = isBig ? 1.7 : 1.0;
    final double horizontalBigFactor = isBig ? 3.5 : 1.0;
    final padding = EdgeInsets.symmetric(vertical: 15 * verticalBigFactor, horizontal: 20 * horizontalBigFactor);

    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60.0),
      ),
      primary: colorPrimary,
      elevation: 0,
      padding: padding
    );

    if (buttonType == BuButtonType.secondary) {
      buttonStyle = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
          side: BorderSide(color: Theme.of(context).dividerColor)
        ),
        primary: Theme.of(context).scaffoldBackgroundColor,
        onPrimary: colorPrimary,
        elevation: 0,
        padding: padding,
      );
    }

    if (buttonType == BuButtonType.secondaryGrey) {
      buttonStyle = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
          side: BorderSide(color: Theme.of(context).dividerColor)
        ),
        primary: Theme.of(context).scaffoldBackgroundColor,
        onPrimary: colorBlueGrey,
        elevation: 0,
        padding: padding,
      );
    }

    if (buttonType == BuButtonType.coloredSecondary) {
      buttonStyle = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
          side: const BorderSide(color: colorSecondary)
        ),
        primary: Theme.of(context).scaffoldBackgroundColor,
        onPrimary: colorSecondary,
        elevation: 0,
        padding: padding,
      );
    }

    if (buttonType == BuButtonType.outlineRed) {
      buttonStyle = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
          side: const BorderSide(color: Color(0xffe01c1c))
        ),
        primary: Theme.of(context).scaffoldBackgroundColor,
        onPrimary: const Color(0xffe01c1c),
        elevation: 0,
        padding: padding,
      );
    }

    if (buttonType == BuButtonType.outlineGreen) {
      buttonStyle = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
          side: const BorderSide(color: Color(0xff17ba63))
        ),
        primary: Theme.of(context).scaffoldBackgroundColor,
        onPrimary: const Color(0xff17ba63),
        elevation: 0,
        padding: padding,
      );
    }

    return icon == null ?
      ElevatedButton(
        style: buttonStyle,
        onPressed: onPressed, 
        child: Text(text),
      ) :
      ElevatedButton.icon(
        style: buttonStyle,
        onPressed: onPressed, 
        label: Text(text),
        icon: Icon(icon),
      );   
  }
}