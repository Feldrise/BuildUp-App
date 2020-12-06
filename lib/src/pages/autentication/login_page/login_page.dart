import 'package:buildup/entities/user.dart';
import 'package:buildup/services/authentication_service.dart';
import 'package:buildup/src/pages/autentication/login_page/widgets/login_form.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_checkbox.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormState = GlobalKey<FormState>();

  bool _hasError = false;
  String _statusMessage = "";

  bool _rememberMe = false;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {    
    return LayoutBuilder(
      builder: (context, constraints) {
        final double dialogWidth = constraints.maxWidth <= 366 ? constraints.maxWidth : 366;
        final double dialogHeight = constraints.maxWidth <= 366 ? constraints.maxHeight : _hasError ? 630 : 500;

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
                        if (_hasError && _statusMessage.isNotEmpty) ...{
                          BuStatusMessage(
                            title: "Erreur lors de la connexion :",
                            message: _statusMessage,
                          ),
                          const SizedBox(height: 16.0,),
                        },
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
                            onPressed: _login
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

  Future _login() async {
    setState(() {
      _hasError = false;
      _statusMessage = "Connexion en cours...";
    });

    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, _statusMessage); 

    try {
      final String username = _emailTextController.text;
      final String password = _passwordTextController.text;

      final User loggedUser = await AuthenticationService.instance.login(username, password, remember: _rememberMe);

      setState(() {
        _hasError = false;
        _statusMessage = "";
      });

      Provider.of<UserStore>(context, listen: false).loginUser(loggedUser);
    } on PlatformException catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = e.message;
      });
    } on Exception catch(e) {
      setState(() {
        _hasError = true;
        _statusMessage = e.toString();
      });
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
  }
}