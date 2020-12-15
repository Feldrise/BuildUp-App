import 'package:flutter/material.dart';

import 'package:buildup/utils/colors.dart';

enum BuButtonType { primary, secondary, coloredSecondary, outlineRed, outlineGreen }

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
    final Row child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...{
          Icon(icon),
          const SizedBox(width: 4.0,)
        },
        
        Text(text, textAlign: TextAlign.center,),
      ],
    );

    final double verticalBigFactor = isBig ? 1.7 : 1.0;
    final double horizontalBigFactor = isBig ? 3.5 : 1.0;
    final padding = EdgeInsets.symmetric(vertical: 15 * verticalBigFactor, horizontal: 20 * horizontalBigFactor);

    if (buttonType == BuButtonType.secondary) {
      return RaisedButton(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
          side: BorderSide(color: Theme.of(context).dividerColor)
        ),
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        textColor: Theme.of(context).primaryColor,
        onPressed: onPressed,
        child: child
      );
    }
    
    if (buttonType == BuButtonType.coloredSecondary) {
      return RaisedButton(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
          side: const BorderSide(color: colorSecondary)
        ),
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        textColor: colorSecondary,
        onPressed: onPressed,
        child: child
      );
    }

    if (buttonType == BuButtonType.outlineRed) {
      return RaisedButton(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
          side: const BorderSide(color: Color(0xffe01c1c))
        ),
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        textColor: const Color(0xffe01c1c),
        onPressed: onPressed,
        child: child
      );
    }

    if (buttonType == BuButtonType.outlineGreen) {
      return RaisedButton(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
          side: const BorderSide(color: Color(0xff17ba63))
        ),
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        textColor: const Color(0xff17ba63),
        onPressed: onPressed,
        child: child
      );
    }

    return RaisedButton(
        padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60.0)
      ),
      elevation: 0,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: onPressed,
      child: child
    );
   
  }
}