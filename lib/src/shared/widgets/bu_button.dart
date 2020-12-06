import 'package:flutter/material.dart';

import 'package:buildup/utils/colors.dart';

enum BuButtonType { primary, secondary, coloredSecondary }

class BuButton extends StatelessWidget {
  const BuButton({
    Key key,
    this.icon,
    @required this.text,
    @required this.onPressed,
    this.buttonType = BuButtonType.primary
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function() onPressed;

  final BuButtonType buttonType;

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

    if (buttonType == BuButtonType.secondary) {
      return RaisedButton(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 38),
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
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 38),
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

    return RaisedButton(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 38),
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