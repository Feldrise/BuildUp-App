import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/features/authentication/widgets/authentication_card.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isFullWidth = constraints.maxWidth <= ScreenUtils.instance.breakpointTablet;
          final double dialogWidth = isFullWidth ? constraints.maxWidth : 411;
          final double dialogHeight = isFullWidth ? constraints.maxHeight : 600;

          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_login.png"),
                fit: BoxFit.cover
              )
            ),
            child: Center(
              child: AuthenticationCard(
                width: dialogWidth, 
                height: dialogHeight, 
                isFullWidth: isFullWidth
              ),
            ),
          );
        },
      ),
    );
  }
}