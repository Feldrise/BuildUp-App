import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/shared/widgets/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_textinput.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminActiveCoachProfileDialog extends StatefulWidget {
  const AdminActiveCoachProfileDialog({Key key, @required this.coach}) : super(key: key); 
  
  final Coach coach;

  @override
  _AdminActiveCoachProfileDialogState createState() => _AdminActiveCoachProfileDialogState();
}

class _AdminActiveCoachProfileDialogState extends State<AdminActiveCoachProfileDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _discordTagTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _passwordConfirmTextController = TextEditingController();

  final TextEditingController _descriptionTextControler = TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstNameTextController.text = widget.coach.associatedUser.firstName;
    _lastNameTextController.text = widget.coach.associatedUser.lastName;

    _emailTextController.text = widget.coach.associatedUser.email;
    _discordTagTextController.text = widget.coach.associatedUser.discordTag;
    _descriptionTextControler.text = widget.coach.description;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: colorScaffoldGrey,
      child: BuCard(
        padding: EdgeInsets.zero,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: BuAppBar(
            backgroundColor: Colors.transparent,
            title: Text("Modifier le profil de ${widget.coach.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 722) {
                          return _buildBigLayout();
                        }
                        else if (constraints.maxWidth > 411) {
                          return _buildMediumLayout();
                        }

                        return _buildSmallLayout();
                      },
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    SizedBox(
                      width: 200,
                      child: BuButton(
                        buttonType: BuButtonType.secondary,
                        text: "Annuler", 
                        onPressed: _cancel
                      ),
                    ),
                    const SizedBox(width: 15, height: 15,),
                    SizedBox(
                      width: 200,
                      child: BuButton(
                        icon: Icons.edit,
                        text: "Modifier",
                        onPressed: _save,
                      ),
                    )
                  ],
                )
              ],
            )
          ),
        )
      ),
    );
  }

  Widget _buildBigLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImagePicker(),
        const SizedBox(width: 15,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildGeneralInfoColumn(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 4,
                      child: _buildPasswordColumn(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              _buildDescription(),
            ],
          ),
        )
      ],
    );
  }

  
  Widget _buildMediumLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImagePicker(),
        const SizedBox(width: 15,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(child: _buildGeneralInfoColumn()),
              const SizedBox(height: 30,),
              _buildDescription(),
              const SizedBox(height: 30),
              Flexible(child: _buildPasswordColumn()),
            ],
          ),
        )
      ],
    );
  }

  
  
  Widget _buildSmallLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(child: _buildImagePicker()),
        const SizedBox(height: 15,),
        Flexible(child: _buildGeneralInfoColumn()),
        const SizedBox(height: 30,),
        _buildDescription(),
        const SizedBox(height: 30),
        Flexible(child: _buildPasswordColumn()),
      ],
    );
  }

  Widget _buildImagePicker() {
    return SizedBox(
      height: 112,
      width: 112,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(56),
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildGeneralInfoColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Text("Informations générales", style: Theme.of(context).textTheme.headline6,),
        ),
        const SizedBox(height: 40,),
        Flexible(
          child: BuTextInput(
            controller: _lastNameTextController,
            labelText: "Nom",
            hintText: "Nom",
            validator: (value) {
              if (value.isEmpty) {
                return "Vous devez rentrer un nom";
              }

              return null;
            },
            onSaved: (value) {
              widget.coach.associatedUser.lastName = value;
            },
          ),
        ),
        const SizedBox(height: 20,),
        Flexible(
          child: BuTextInput(
            controller: _firstNameTextController,
            labelText: "Prénom",
            hintText: "Prénom",
            validator: (value) {
              if (value.isEmpty) {
                return "Vous devez rentrer un prénom";
              }

              return null;
            },
            onSaved: (value) {
              widget.coach.associatedUser.firstName = value;
            },
          ),
        )
      ],
    );
  }

  Widget _buildPasswordColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Row(
            children: [
              const Icon(Icons.lock_outline, size: 15,),
              const SizedBox(width: 5,),
              Expanded(
                child: Text("Modifier le mot de passe", style: Theme.of(context).textTheme.headline6,)
              ),
            ],
          ),
        ),
        const SizedBox(height: 40,),
        Flexible(
          child: BuTextInput(
            controller: _passwordTextController,
            obscureText: true,
            labelText: "Nouveau mot de passe",
            hintText: "Mot de passe",
            validator: (value) {
              if (_passwordConfirmTextController.text.isNotEmpty) {
                return "Le mot de passe et la confirmation ne correspondent pas";
              }

              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),
        Flexible(
          child: BuTextInput(
            controller: _passwordConfirmTextController,
            obscureText: true,
            labelText: "Nouveau mot de passe (confirmation)",
            hintText: "Mot de passe",
            validator: (value) {
              if (value.isEmpty && _passwordTextController.text.isNotEmpty) {
                return "Le mot de passe ne peut pas être vide";
              }

              if (value != _passwordTextController.text) {
                return "Le mot de passe et la confirmation ne correspondent pas";
              }

              return null;
            },
            onSaved: (value) {
              widget.coach.associatedUser.newPassword = value;
            },
          ),
        ),
      ]
    );
  }

  Widget _buildDescription() {
    return Flexible(
      child: BuTextInput(
        controller: _descriptionTextControler,
        inputType: TextInputType.multiline,
        maxLines: 5,
        labelText: "Description",
        hintText: "Description",
        validator: (value) {
          if (value.isEmpty) {
            return "Vous devez rentrer une description";
          }

          return null;
        },
        onSaved: (value) {
          widget.coach.description = value;
        },
      ),
    );
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  Future _save() async {

  }
}