import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/project.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_date_form_field.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_textinput.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuilderProjectDialog extends StatefulWidget {
  const BuilderProjectDialog({
    Key? key, 
    required this.builder,
    required this.onSaveProject,
  }) : super(key: key);

  final BuBuilder builder;

  final Function(BuBuilder) onSaveProject;

  @override
  _BuilderProjectDialogState createState() => _BuilderProjectDialogState();
}

class _BuilderProjectDialogState extends State<BuilderProjectDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _keywordsTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  final TextEditingController _teamTextController = TextEditingController();

  late String _currentCategorie;
  late bool _currentIsLucrative;
  late bool _currentIsDeclared;

  String _statusMessage = "";
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    _currentIsLucrative =  widget.builder.associatedProjects.first.isLucrative;
    _currentIsDeclared =  widget.builder.associatedProjects.first.isDeclared;
    _currentCategorie = widget.builder.associatedProjects.first.categorie;

    _nameTextController.text= widget.builder.associatedProjects.first.name;
    _keywordsTextController.text = widget.builder.associatedProjects.first.keywords;
    _descriptionTextController.text = widget.builder.associatedProjects.first.description;
    _teamTextController.text = widget.builder.associatedProjects.first.team;
  }
  
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ScreenUtils.instance.horizontalPadding;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
      color: colorScaffoldGrey,
      child: BuCard(
        padding: EdgeInsets.zero,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: BuAppBar(
            backgroundColor: Colors.transparent,
            title: Text("Modifier le projet de ${widget.builder.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildBasicInfo(),
                          const SizedBox(height: 15,),
                          Flexible(child: _buildRadios()),
                          const SizedBox(height: 15,),
                          Flexible(
                            child: BuTextInput(
                              controller: _keywordsTextController,
                              labelText: "Mots clés",
                              hintText: "Mots clés",
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Vous devez mettre des mots clés";
                                }

                                return null;
                              },
                              onSaved: (value) => widget.builder.associatedProjects.first.keywords = value,
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Flexible(
                            child: BuTextInput(
                              controller: _descriptionTextController,
                              labelText: "Description",
                              hintText: "Description",
                              inputType: TextInputType.multiline,
                              maxLines: 3,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Vous devez mettre une description";
                                }

                                return null;
                              },
                              onSaved: (value) => widget.builder.associatedProjects.first.description = value,
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Flexible(
                            child: BuTextInput(
                              controller: _teamTextController,
                              labelText: "L'équipe",
                              hintText: "Les membres de l'équipe",
                              inputType: TextInputType.multiline,
                              maxLines: 2,
                              validator: null,
                              onSaved: (value) => widget.builder.associatedProjects.first.team = value,
                            ),
                          )
                        ],
                      )
                    )
                  )
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
              ]
            )
          )
        )
      )
    );  
  }

  Widget _buildBasicInfo() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = (constraints.maxWidth - 30) / 3;
        width = width < 200 ? (constraints.maxWidth - 15) / 2 : width;
        width = width < 200 ? (constraints.maxWidth) : width;

        return Wrap(
          spacing: 15,
          children: [
            SizedBox(
              width: width,
              child: BuTextInput(
                controller: _nameTextController,
                labelText: "Nom",
                hintText: "Nom",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Vous devez mettre un nom";
                  }

                  return null;
                },
                onSaved: (value) => widget.builder.associatedProjects.first.name = value
              ),
            ),
            SizedBox(
              width: width,
              child: BuDropdown<String>(
                label: "Catégorie",
                items: ProjectCategories.map, 
                currentValue: _currentCategorie,
                onChanged: (value) {
                  setState(() {
                    _currentCategorie = value ?? "Inconnue";
                  });
                }
              ),
            ),
            SizedBox(
              width: width,
              child: BuDateFormField(
                context: context, 
                firstDate: DateTime.fromMillisecondsSinceEpoch(0), 
                lastDate: DateTime.now().add(const Duration(days: 356 * 5)),
                initialValue: widget.builder.associatedProjects.first.launchDate,
                onSave: (value) =>  widget.builder.associatedProjects.first.launchDate = value ?? DateTime.now(),
              )
            )
          ]
        );
      },
    );
  }

  Widget _buildRadios() {
    return Wrap(
      spacing: 15,
      children: [
        _buildSmallInfo("Projet Lucratif", Row(
          children: <Widget>[
            Flexible(
              child: Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: _currentIsLucrative,
                    onChanged: (value) {
                      setState(() {
                        _currentIsLucrative = value ?? true;
                      });
                    },
                  ),
                  const SizedBox(width: 5,),
                  const Text('Oui'),
                ]
              )
            ),
            Flexible(
              child: Row(
                children: [
                  Radio<bool>(
                    value: false,
                    groupValue: _currentIsLucrative,
                    onChanged: (value) {
                      setState(() {
                        _currentIsLucrative = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(width: 5,),
                  const Text('Non'),
                ]
              )
            ),
          ],
        )),
        _buildSmallInfo("Projet déclaré", Row(
          children: <Widget>[
            Flexible(
              child: Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: _currentIsDeclared,
                    onChanged: (value) {
                      setState(() {
                        _currentIsDeclared = value ?? true;
                      });
                    },
                  ),
                  const SizedBox(width: 5,),
                  const Text('Oui'),
                ]
              )
            ),
            Flexible(
              child: Row(
                children: [
                  Radio<bool>(
                    value: false,
                    groupValue: _currentIsDeclared,
                    onChanged: (value) {
                      setState(() {
                        _currentIsDeclared = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(width: 5,),
                  const Text('Non'),
                ]
              )
            ),
          ],
        )),
      ],
    ); 
  }

  
  Widget _buildSmallInfo(String title, Widget info) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: const TextStyle(fontSize: 14, color: Color(0xff919191)),),
          const SizedBox(height: 5,),
          info
        ],  
      ),
    );
  } 

  void _cancel() {
    Navigator.of(context).pop();
  }

  Future _save() async {
    if (_formKey.currentState == null) {
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.builder.associatedProjects.first.categorie = _currentCategorie;
      widget.builder.associatedProjects.first.isLucrative = _currentIsLucrative;
      widget.builder.associatedProjects.first.isDeclared = _currentIsDeclared;
      
      final GlobalKey<State> keyLoader = GlobalKey<State>();
      Dialogs.showLoadingDialog(context, keyLoader, "Mise à jour des informations..."); 

      try {
        await widget.onSaveProject(widget.builder);

        setState(() {
          _hasError = false;
          _statusMessage = "Le projet a bien été mis à jour.";
        });
      } on PlatformException catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Erreur lors de la mise à jour du projet : ${e.message}";
        });
      } on Exception catch(e) {
        setState(() {
          _hasError = true;
          _statusMessage = "Erreur lors de la mise à jour du projet : $e";
        });
      }

      if (keyLoader.currentContext != null) {
        Navigator.of(keyLoader.currentContext!,rootNavigator: true).pop(); 
      }
    }
  }
}