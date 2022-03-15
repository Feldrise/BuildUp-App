import 'package:buildup/core/utils/constants.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/core/widgets/inputs/bu_datefield.dart';
import 'package:buildup/core/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/core/widgets/inputs/bu_radio.dart';
import 'package:buildup/core/widgets/inputs/bu_textfield.dart';
import 'package:buildup/core/widgets/small_info.dart';
import 'package:buildup/features/project/project.dart';
import 'package:buildup/features/project/project_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProjectCardForm extends StatefulWidget {
  const ProjectCardForm({
    Key? key,
    required this.userID,
    required this.project,
    required this.onPop,
    this.refetch
  }) : super(key: key);

  final String userID;

  final Project project;
  final Function() onPop;

  final Refetch? refetch;

  @override
  State<ProjectCardForm> createState() => _ProjectCardFormState();
}

class _ProjectCardFormState extends State<ProjectCardForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _keywordsTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  final TextEditingController _teamTextController = TextEditingController();

  late String _currentCategory;
  late bool _currentIsLucrative;
  late bool _currentIsOfficialyRegistered;

  String _statusMessage = "";

  MutationOptions<dynamic> _updateMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(qMutUpdateProject),
      onError: (error) {
        _statusMessage = "Le projet n'a pas pu être mis à jour...";
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        if (widget.refetch != null) widget.refetch!();
        widget.onPop();
      }
    );
  }

  void _initialize() {
    _nameTextController.text = widget.project.name;
    _keywordsTextController.text = widget.project.keywords ?? "";
    _descriptionTextController.text = widget.project.description;
    _teamTextController.text = widget.project.team ?? "";

    _currentCategory = widget.project.categorie ?? "Autre catégorie";
    _currentIsLucrative = widget.project.isLucarative ?? false;
    _currentIsOfficialyRegistered = widget.project.isOfficialyRegistered ?? false;
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant ProjectCardForm oldWidget) {
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

        return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The title
              Text("Modifier le projet", style: Theme.of(context).textTheme.headline3,),
              const SizedBox(height: 40,),
        
              if (_statusMessage.isNotEmpty) ...{
                Flexible(
                  child: BuStatusMessage(
                    message: _statusMessage,
                  ),
                ),
                const SizedBox(height: 20,),
              },
        
              // The basics info
              _buildBasicInfo(),
              const SizedBox(height: 15,),
              
              // The radio choices
              Flexible(child: _buildRadios()),
              const SizedBox(height: 15,),
        
              // The keywords
              Flexible(
                child: BuTextField(
                  controller: _keywordsTextController,
                  labelText: "Mots clés",
                  hintText: "Mots clés",
                  validator: (value) {
                    if (value.isEmpty) return "Vous devez mettre des mots clés";
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15,),
        
              // The description
              Flexible(
                child: BuTextField(
                  controller: _descriptionTextController,
                  labelText: "Description",
                  hintText: "Description",
                  inputType: TextInputType.multiline,
                  maxLines: 3,
                  validator: (value) {
                    if (value.isEmpty) return "Vous devez mettre une description";
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15,),
        
              // The team
              Flexible(
                child: BuTextField(
                  controller: _teamTextController,
                  labelText: "L'équipe",
                  hintText: "Les membres de l'équipe",
                  inputType: TextInputType.multiline,
                  maxLines: 2,
                  validator: null,
                ),
              ),
        
              // The buttons
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
          ),
        );
      }
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
            // The name
            SizedBox(
              width: width,
              child: BuTextField(
                controller: _nameTextController,
                labelText: "Nom",
                hintText: "Nom",
                validator: (value) {
                  if (value.isEmpty) return "Vous devez mettre un nom";
                  return null;
                },
              ),
            ),

            // The category
            SizedBox(
              width: width,
              child: BuDropdown<String>(
                label: "Catégorie",
                items: {
                  for (final category in kProjectCategories) 
                    category: category
                }, 
                currentValue: _currentCategory,
                onChanged: (value) {
                  setState(() {
                    _currentCategory = value ?? "Autre catégorie";
                  });
                }
              ),
            ),

            // The launch date
            SizedBox(
              width: width,
              child: BuDateField(
                context: context, 
                firstDate: DateTime.fromMillisecondsSinceEpoch(0), 
                lastDate: DateTime.now().add(const Duration(days: 356 * 5)),
                initialValue: widget.project.launchDate,
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
        // Group for project lucrativity
        SmallInfo(
          width: 200,
          title: "Projet Lucratif",
          child: Row(
            children: <Widget>[
              // Yes radio
              Flexible(
                child: BuRadio<bool>(
                  label: "Oui",
                  value: true,
                  groupValue: _currentIsLucrative,
                  onChanged: (value) {
                    setState(() {
                      _currentIsLucrative = value ?? true;
                    });
                  },
                )
              ),

              // No radio
              Flexible(
                child: BuRadio<bool>(
                  label: "Non",
                  value: false,
                  groupValue: _currentIsLucrative,
                  onChanged: (value) {
                    setState(() {
                      _currentIsLucrative = value ?? false;
                    });
                  },
                )
              ),
            ],
          )
        ),

        // Group for project registration
         SmallInfo(
          width: 200,
          title: "Projet déclaré",
          child: Row(
            children: <Widget>[
              // Yes radio
              Flexible(
                child: BuRadio<bool>(
                  label: "Oui",
                  value: true,
                  groupValue: _currentIsOfficialyRegistered,
                  onChanged: (value) {
                    setState(() {
                      _currentIsOfficialyRegistered = value ?? true;
                    });
                  },
                )
              ),

              // No radio
              Flexible(
                child: BuRadio<bool>(
                  label: "Non",
                  value: false,
                  groupValue: _currentIsOfficialyRegistered,
                  onChanged: (value) {
                    setState(() {
                      _currentIsOfficialyRegistered = value ?? false;
                    });
                  },
                )
              ),
            ],
          )
        ),
      ],
    ); 
  }

  void _onSave(RunMutation saveMutation) {
    if (!_formKey.currentState!.validate()) return;

    saveMutation(<String, dynamic>{
      "userID": widget.userID,
      "name": _nameTextController.text,
      "description": _descriptionTextController.text,
      "team": _teamTextController.text,
      "category": _currentCategory,
      "keywords": _keywordsTextController.text,
      "isLucrative": _currentIsLucrative,
      "isOfficialyRegistered": _currentIsOfficialyRegistered
    });
  }
}