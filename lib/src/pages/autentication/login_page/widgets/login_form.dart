import 'package:buildup/src/shared/widgets/inputs/bu_textinput.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key, 
    required this.formKey, 
    required this.emailTextController,
    required this.passwordTextController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BuTextInput( 
            controller: emailTextController,
            validator: null, 
            labelText: "Adresse Email",
            hintText: "Email",
          ),
          const SizedBox(height: 15.0,),
          BuTextInput( 
            controller: passwordTextController,
            validator: null, 
            obscureText: true,
            labelText: "Mot de passe",
            hintText: "Mot de passe",
          ),
        ],
      ),
    );
  }
}