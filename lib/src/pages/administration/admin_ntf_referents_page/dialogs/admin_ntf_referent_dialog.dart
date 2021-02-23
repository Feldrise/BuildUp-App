import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_textinput.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminNtfReferentDialog extends StatefulWidget {
  const AdminNtfReferentDialog({
    Key key, 
    @required this.ntfReferent
  }) : super(key: key);

  final NtfReferent ntfReferent;


  @override
  _AdminNtfReferentDialogState createState() => _AdminNtfReferentDialogState();
}

class _AdminNtfReferentDialogState extends State<AdminNtfReferentDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _discordTagextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstNameTextController.text = widget.ntfReferent.firstName;
    _lastNameTextController.text = widget.ntfReferent.lastName;
    _emailTextController.text = widget.ntfReferent.email;
    _discordTagextController.text = widget.ntfReferent.discordTag;
  }

  @override
  void didUpdateWidget(covariant AdminNtfReferentDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    _firstNameTextController.text = widget.ntfReferent.firstName;
    _lastNameTextController.text = widget.ntfReferent.lastName;
    _emailTextController.text = widget.ntfReferent.email;
    _discordTagextController.text = widget.ntfReferent.discordTag;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 50),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: const Border(
            top: BorderSide(
              width: 4,
              color: colorPrimary
            )
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(widget.ntfReferent.id == null ? "Ajouter un référent" : "Modifier un référent", style: Theme.of(context).textTheme.headline4,)
                ),
                InkWell(
                  onTap: () => Navigator.pop(context, false),
                  child: const Icon(Icons.close, size: 28,),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            const Divider(),
            Flexible(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double width = constraints.maxWidth > 415 ? (constraints.maxWidth - 15) / 2 : constraints.maxWidth;
                      
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40,),
                          Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            children: [
                              SizedBox(
                                width: width,
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
                                  onSaved: (value) => widget.ntfReferent.lastName = value
                                ),
                              ),
                              SizedBox(
                                width: width,
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
                                  onSaved: (value) => widget.ntfReferent.firstName = value,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            width: width,
                            child: BuTextInput(
                              controller: _emailTextController,
                              labelText: "Email",
                              hintText: "Email",
                              inputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Vous devez rentrer un mail";
                                }

                                final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

                                if (!emailValid) {
                                  return "L'email semble invalide...";
                                }

                                return null;
                              },
                              onSaved: (value) => widget.ntfReferent.email = value
                            ),
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            width: width,
                            child: BuTextInput(
                              controller: _discordTagextController,
                              labelText: "Tag Discord",
                              hintText: "Tag Discord",
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Vous devez rentrer un tag Discord";
                                }

                                return null;
                              },
                              onSaved: (value) => widget.ntfReferent.discordTag = value
                            ),
                          ),
                          const SizedBox(height: 40,),
                        ],
                      );
                    }
                  )
                ),
              ),
            ),
            if (MediaQuery.of(context).size.width > 476) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buildButtons(context),
            ) else Column(
              mainAxisSize: MainAxisSize.min,
              children: buildButtons(context),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildButtons(BuildContext context) {
    return [
      BuButton(
        buttonType: BuButtonType.secondary,
        text: "Annuler",
        onPressed: () => Navigator.pop(context, false),
        isBig: true,
      ),
      BuButton(
        text: "Valider",
        onPressed: _validate,
        isBig: true,
      )
    ];
  }

  void _validate() {
    if (_formKey.currentState.validate()) { 
      _formKey.currentState.save();

      Navigator.of(context).pop(true);
    }
  }
}