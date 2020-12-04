import 'package:buildup/src/pages/autentication/login_page/widgets/login_form.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_checkbox.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginFormState = GlobalKey<FormState>();

  bool _isLoading = false;
  String _statusMessage = "";

  bool _rememberMe = false;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double dialogWidth = constraints.maxWidth <= 366 ? constraints.maxWidth : 366;
        final double dialogHeight = constraints.maxWidth <= 366 ? constraints.maxHeight : 500;

        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/backgrounds/login.png",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              child: SingleChildScrollView(
                child: BuCard(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                  width: dialogWidth,
                  height: dialogHeight,
                  child: Scaffold(
                    backgroundColor: Theme.of(context).cardColor,
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [  
                        Image.asset("assets/icons/icon_buildup.png", height: 56,),
                        const SizedBox(height: 5.0,),
                        Text("Bienvenue ! ", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline3,),
                        const SizedBox(height: 32.0),
                        LoginForm(
                          formKey: _loginFormState,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController,
                        ),
                        const SizedBox(height: 8.0,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: BuCheckBox(
                                value: _rememberMe,
                                text: "Se souvenir de moi",
                                onChanged: (newValue) {
                                  setState(() {
                                    _rememberMe = newValue;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Text("Mot de passe oublié ?", textAlign: TextAlign.end, style: Theme.of(context).textTheme.caption),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 32.0),
                        Flexible(
                          child: BuButton(
                            text: "Se connecter", 
                            onPressed: () {}
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
        
      },
    );
  }
}