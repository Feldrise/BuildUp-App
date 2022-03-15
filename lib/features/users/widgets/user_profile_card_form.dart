import 'package:buildup/core/utils/constants.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/core/widgets/inputs/bu_datefield.dart';
import 'package:buildup/core/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/core/widgets/inputs/bu_textfield.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/users_graphql.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProfileCardForm extends StatefulWidget {
  const UserProfileCardForm({
    Key? key,
    required this.user,
    required this.onPop,
    required this.refetch,
  }) : super(key: key);

  final User user;
  final Function() onPop;

  final Future<QueryResult<Map<String, dynamic>>?> Function()? refetch;

  @override
  State<UserProfileCardForm> createState() => _UserProfileCardFormState();
}

class _UserProfileCardFormState extends State<UserProfileCardForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _discordTagTextController = TextEditingController();
  final TextEditingController _linkedinTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _passwordConfirmTextController = TextEditingController();

  final TextEditingController _descriptionTextControler = TextEditingController();

  late String _currentSituation;

  String _statusMessage = "";

  MutationOptions<dynamic> _updateMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(qMutUpdateUser),
      onError: (error) {
        _statusMessage = "Le profil n'a pas pu être mis à jour...";
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        if (widget.refetch != null) widget.refetch!();
        widget.onPop();
      }
    );
  }

  void _initialize() {
    _firstNameTextController.text = widget.user.firstName;
    _lastNameTextController.text = widget.user.lastName;

    _emailTextController.text = widget.user.email;
    _discordTagTextController.text = widget.user.discord ?? "";
    _linkedinTextController.text = widget.user.linkedin ?? "";
    _descriptionTextControler.text = widget.user.description;

    _currentSituation = widget.user.situation;
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant UserProfileCardForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The back button
        IconButton(
          onPressed: widget.onPop,
          icon: const Icon(Icons.arrow_back),
        ),

        // The content
        Expanded(
          child: _buildContent(),
        )
      ],
    );
  }

  Widget _buildContent() {
    return Mutation<dynamic>(
      options: _updateMutationOptions(),
      builder: (updateRunMutation, updateMutationResult) {
        if (updateMutationResult?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The title
            Text("Modifier le profil", style: Theme.of(context).textTheme.headline3,),
            const SizedBox(height: 40,),

            if (_statusMessage.isNotEmpty) ...{
              Flexible(
                child: BuStatusMessage(
                  message: _statusMessage,
                ),
              ),
              const SizedBox(height: 20,),
            },

            // The content
            Flexible(
              child: Form(
                key: _formKey,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return _buildBigLayout();
                  },
                ),
              ),
            ),
            const SizedBox(height: 20,),

            // The button
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Cancel button
                  OutlinedButton(
                    onPressed: widget.onPop,
                    child: const Text("Annuler"),
                  ),
                  const SizedBox(width: 12,),

                  // The validate button
                  ElevatedButton(
                    onPressed: () => _onSave(updateRunMutation), 
                    child: Row(
                      children: const [
                        Icon(Icons.edit, size: 12,),
                        SizedBox(width: 4,),
                        Text("Modifier")
                      ],
                    )
                  )
                ],
              ),
            )
          ],
        );
      }
    );
  }

  Widget _buildBigLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The image picker
        _buildImagePicker(),
        const SizedBox(width: 50,),

        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // The general info column
                    Flexible(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 350),
                        child: _buildGeneralInfoColumn(),
                      )
                    ),
              
                    // The password column
                    Flexible(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 350),
                        child: _buildPasswordColumn(),
                      )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),

              Flexible(child: _buildDescriptionField())
            ],
          ),
        )
      ],
    );
  }

  Widget _buildImagePicker() {
    return Container(
      decoration: BoxDecoration(
        color: Palette.colorLightGrey3,
        borderRadius: BorderRadius.circular(48)
      ),
      width: 92, height: 92,
    );
  }

  Widget _buildGeneralInfoColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The title 
        Text(
          "Information générales", 
          style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 40,),

        // The last name
        Flexible(
          child: BuTextField(
            controller: _lastNameTextController,
            labelText: "Nom",
            hintText: "Rentrer votre nom",
            validator: (value) {
              if (value.isEmpty) return "Vous devez rentrer votre nom";
              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),

        // The first name
        Flexible(
          child: BuTextField(
            controller: _firstNameTextController,
            labelText: "Prénom",
            hintText: "Rentrer votre prénom",
            validator: (value) {
              if (value.isEmpty) return "Vous devez rentrer votre prénom";
              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),

        // The birthdate
        Flexible(
          child: BuDateField(
            context: context,
            firstDate: DateTime.fromMillisecondsSinceEpoch(0),
            lastDate: DateTime.now(),
            initialValue: widget.user.birthdate,
            label: "Date de naissance",
            validator: (value) {
              if (value == null) {
                return "Une date est obligatoire";
              }

              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),

        // The situation
        Flexible(
          child: BuDropdown<String>(
            label: "Situation",
            currentValue: _currentSituation,
            items: {
              for (final situation in kSituations) 
                situation: situation
            },
            onChanged: (value) {
              setState(() {
                _currentSituation = value ?? "Situation Inconnue";
              });
            },
          ),
        ),
        const SizedBox(height: 20,),

        // The email
        Flexible(
          child: BuTextField(
            controller: _emailTextController,
            labelText: "Email",
            hintText: "Rentrer votre email",
            validator: (value) {
              if (value.isEmpty) return "Vous devez rentrer votre email";

              final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

              if (!emailValid) {
                return "L'email semble invalide...";
              }

              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),

        // The Discord tag
        Flexible(
          child: BuTextField(
            controller: _discordTagTextController,
            labelText: "Tag Discord",
            hintText: "Rentrer votre Discord",
            validator: (value) {
              if (value.isEmpty) return "Vous devez rentrer votre tag Discord";
              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),

        // The linkedin Link
        Flexible(
          child: BuTextField(
            controller: _linkedinTextController,
            labelText: "Lien profil LinkedIn",
            hintText: "Rentrer votre LinkedIn",
            validator: (value) {
              if (value.isEmpty) return "Vous devez rentrer votre lien LinkedIn";
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The title
        Flexible(
          child: Row(
            children: [
              const Icon(Icons.lock_outline, size: 15,),
              const SizedBox(width: 5,),
              Flexible(
                child: Text(
                  "Modifier le mot de passe", 
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            ],
          ),
        ),
        const SizedBox(height: 40,),

        // The password field
        Flexible(
          child: BuTextField(
            controller: _passwordTextController,
            obscureText: true,
            labelText: "Nouveau mot de passe",
            hintText: "Mot de passe",
            validator: null,
          ),
        ),
        const SizedBox(height: 20,),

        // The password confirmation field
        Flexible(
          child: BuTextField(
            controller: _passwordConfirmTextController,
            obscureText: true,
            labelText: "Nouveau mot de passe (confirmation)",
            hintText: "Mot de passe",
            validator: (value) {
              if (value.isEmpty && _passwordTextController.text.isNotEmpty) {
                return "La confirmation ne peut pas être vide";
              }

              if (value != _passwordTextController.text) {
                return "Le mot de passe et la confirmation ne correspondent pas";
              }

              return null;
            },
          ),
        ),
      ]
    );
  }

  Widget _buildDescriptionField() {
    return BuTextField(
      controller: _descriptionTextControler,
      labelText: "Description",
      hintText: "Rentrer une description",
      inputType: TextInputType.multiline,
      maxLines: 3,
      validator: (value) {
        if (value.isEmpty) return "Vous devez rentrer une description";
        return null;
      },
    );
  }

  void _onSave(RunMutation saveMutation) {
    if (!_formKey.currentState!.validate()) return;

    saveMutation(<String, dynamic>{
      "id": widget.user.id,
      "email": _emailTextController.text,
      "firstName": _firstNameTextController.text,
      "lastName": _lastNameTextController.text,
      "description": _descriptionTextControler.text,
      "situation": _currentSituation,
      "discord": _discordTagTextController.text,
      "linkedin": _linkedinTextController.text
    });
  }
}