import 'package:flutter/material.dart';

class AuthenticationHeader extends StatelessWidget {
  const AuthenticationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // The buildup logo
        const Image(
          image: AssetImage("assets/images/buildup.png"),
          height: 51,
          fit: BoxFit.fitWidth,
        ),

        // the welcome text
        Text(
          "Bienvenue !", 
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        )
      ],
    );
  }
}