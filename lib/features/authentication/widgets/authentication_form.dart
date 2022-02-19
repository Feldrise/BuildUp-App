import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/core/widgets/inputs/bu_textfield.dart';
import 'package:buildup/features/authentication/app_user_controller.dart';
import 'package:buildup/features/authentication/authentication_graphql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthenticationForm extends ConsumerStatefulWidget {
  const AuthenticationForm({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends ConsumerState<AuthenticationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  MutationOptions<Map<String, dynamic>> _mutationOptions() {
    return MutationOptions(
      document: gql(qMutAuthenticationLogin),
      onCompleted: (dynamic data) async {
        final String token = data['login'] as String? ?? "";
        
        if (token.isNotEmpty) {
          // First we need to save the login info
          final String email = _emailTextController.text;
          final String password = _passwordTextController.text;

          const storage = FlutterSecureStorage();
          await storage.write(key: "user_username", value: email);
          await storage.write(key: "user_password", value: password);
          
          // Then we can actually login the user
          ref.read(appUserControllerProvider.notifier).loginUser(token);
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Mutation<Map<String, dynamic>>(
      options: _mutationOptions(),
      builder: (runMutation, result) {
        if (result?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return _buildContent(runMutation, result);
      },
    );
  }

  Widget _buildContent(RunMutation runMutation, QueryResult<Map<String, dynamic>>? mutationResult) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Check for errors
          if (mutationResult?.hasException ?? false) ...{
            const BuStatusMessage(
              title: "Impossible de se connecter",
              message: "Vérifier bien votre email et votre mot de passe",
            ),
            const SizedBox(height: 20,)
          },

          // Email field
          Flexible(
            child: BuTextField(
              controller: _emailTextController,
              labelText: "Adresse mail",
              hintText: "Entrez votre adresse mail...",
              inputType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) return "L'adresse mail ne doit pas être vide";
          
                return null;
              },
            ),
          ),
          const SizedBox(height: 12,),

          // Password field
          Flexible(
            child: BuTextField(
              controller: _passwordTextController,
              labelText: "Mot de Passe",
              hintText: "Entrez votre mot de passe...",
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) return "Le mot de passe ne doit pas être vide";
          
                return null;
              },
            ),
          ),
          const SizedBox(height: 40,),

          // Validation button
          Center(
            child: ElevatedButton(
              child: const Text("Se connecter"),
              onPressed: () => _onLoginClicked(runMutation),
            ),
          )
        ],
      ),
    );
  }

  void _onLoginClicked(RunMutation runMutation) async {
    if (!_formKey.currentState!.validate()) return;

    runMutation(<String, dynamic>{
      "email": _emailTextController.text,
      "password": _passwordTextController.text
    });
  }
}