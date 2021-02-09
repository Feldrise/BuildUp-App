
import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_date_form_field.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_image_picker.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_textinput.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoachProfileDialog extends StatefulWidget {
  const CoachProfileDialog({Key key, @required this.coach, this.onSaveCoachProfile}) : super(key: key); 
  
  final Coach coach;

  final Function(Coach) onSaveCoachProfile;

  @override
  _CoachProfileDialogState createState() => _CoachProfileDialogState();
}

class _CoachProfileDialogState extends State<CoachProfileDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _discordTagTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _passwordConfirmTextController = TextEditingController();

  final TextEditingController _descriptionTextControler = TextEditingController();

  String _currentSituation;
  int _currentDepartment;

  bool _hasError = false;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();

    _firstNameTextController.text = widget.coach.associatedUser.firstName;
    _lastNameTextController.text = widget.coach.associatedUser.lastName;

    _emailTextController.text = widget.coach.associatedUser.email;
    _discordTagTextController.text = widget.coach.associatedUser.discordTag;
    _descriptionTextControler.text = widget.coach.description;

    _currentSituation = widget.coach.situation;
    _currentDepartment = widget.coach.associatedUser.department;
  }

  @override
  void didUpdateWidget(covariant CoachProfileDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    _firstNameTextController.text = widget.coach.associatedUser.firstName;
    _lastNameTextController.text = widget.coach.associatedUser.lastName;

    _emailTextController.text = widget.coach.associatedUser.email;
    _discordTagTextController.text = widget.coach.associatedUser.discordTag;
    _descriptionTextControler.text = widget.coach.description;

    _currentSituation = widget.coach.situation;
    _currentDepartment = widget.coach.associatedUser.department;
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
                if (_statusMessage.isNotEmpty) ...{ 
                  BuStatusMessage(
                    type: _hasError ? BuStatusMessageType.error : BuStatusMessageType.success,
                    title: _hasError ? "Erreur" : "Bravo !",
                    message: _statusMessage,
                  ),
                  const SizedBox(height: 15),
                },
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
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
                ),
                const SizedBox(height: 30,),
                Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: BuButton(
                          buttonType: BuButtonType.secondary,
                          text: "Annuler", 
                          onPressed: _cancel
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: BuButton(
                          icon: Icons.edit,
                          text: "Modifier",
                          onPressed: _save,
                        ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
      child: BuImagePicker(
        image: widget.coach.associatedUser.profilePicture,
        isCircular: true,
      )
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
        ),
        const SizedBox(height: 20,),
        Flexible(
          child: BuDateFormField(
            context: context,
            firstDate: DateTime.fromMillisecondsSinceEpoch(0),
            lastDate: DateTime.now(),
            initialValue: widget.coach.associatedUser.birthdate,
            label: "Date de naissance",
            validator: (value) {
              if (value == null) {
                return "Une date est obligatoire";
              }

              return null;
            },
            onSave: (value) {
              widget.coach.associatedUser.birthdate = value;
            },
          ),
        ),
        const SizedBox(height: 20,),
        Flexible(
          child: BuDropdown<int>(
            label: "Département",
            items: kFrenchDepartment, 
            currentValue: _currentDepartment,
            onChanged: (value) {
              setState(() {
                _currentDepartment = value;
              });
            }
          ),
        ),
        const SizedBox(height: 20,),
        Flexible(
          child: BuDropdown<String>(
            label: "Situation",
            items: kSituations, 
            currentValue: _currentSituation,
            onChanged: (value) {
              setState(() {
                _currentSituation = value;
              });
            }
          ),
        ),
        const SizedBox(height: 20,),
        Flexible(
          child: BuTextInput(
            controller: _emailTextController,
            inputType: TextInputType.emailAddress,
            labelText: "Email",
            hintText: "Email",
            validator: (value) {
              if (value.isEmpty) {
                return "Vous devez rentrer une email";
              }

              final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

              if (!emailValid) {
                return "L'email semble invalide...";
              }

              return null;
            },
            onSaved: (value) {
              widget.coach.associatedUser.email = value;
            },
          ),
        ),
        const SizedBox(height: 20,),
        Flexible(
          child: BuTextInput(
            controller: _discordTagTextController,
            labelText: "Tag Discord",
            hintText: "Tag Discord",
            validator: (value) {
              if (value.isEmpty) {
                return "Vous devez rentrer un tag Discord";
              }

              return null;
            },
            onSaved: (value) {
              widget.coach.associatedUser.discordTag = value;
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
                return "La confirmation ne peut pas être vide";
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
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.coach.situation = _currentSituation;
      widget.coach.associatedUser.department = _currentDepartment;
      
      final GlobalKey<State> keyLoader = GlobalKey<State>();
      Dialogs.showLoadingDialog(context, keyLoader, "Mise à jour des informations..."); 

      try {
        await widget.onSaveCoachProfile(widget.coach);
        
        setState(() {
          _hasError = false;
          _statusMessage = "Le profil a bien été mis à jour.";
        });
      } on PlatformException catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Erreur lors de la mise à jour du profil : ${e.message}";
        });
      } on Exception catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Erreur lors de la mise à jour du profil : $e";
        });
      }

      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
    }
  }
}