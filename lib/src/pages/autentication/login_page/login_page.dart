import 'package:buildup/src/pages/autentication/login_page/widgets/login_form.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_checkbox.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginFormState = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _hasError = false;
  String _statusMessage = "";
  final List<GlobalKey<State>> _loadKeyLoaders = [];

  bool _rememberMe = false;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {    
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      for (final keyLoader in _loadKeyLoaders) {
        Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
      }

      _loadKeyLoaders.clear();

      if (_isLoading) {
        _loadKeyLoaders.add(GlobalKey<State>());
        Dialogs.showLoadingDialog(context, _loadKeyLoaders.last, _statusMessage); 
      }
    });

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
      _isLoading = true;
      _statusMessage = "Connexion en cours...";
    });

    await Future<void>.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoading = false;
      _hasError = true;
      _statusMessage = "Votre mot de passe ou votre email est incorrect";
    });
  }
}