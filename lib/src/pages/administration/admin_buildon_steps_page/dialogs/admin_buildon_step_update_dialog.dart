import 'package:buildup/entities/buildons/buildon_returning.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_dropdown.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_image_picker.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_textinput.dart';
import 'package:flutter/material.dart';

class AdminBuildOnStepUpdateDialog extends StatefulWidget {
  const AdminBuildOnStepUpdateDialog({
    Key key,
    @required this.buildOnStep,
    @required this.onUpdated,
    @required this.onClosed,
    @required this.formKey,
  }) : super(key: key);

  final BuildOnStep buildOnStep;

  final Function() onUpdated;
  final Function() onClosed;

  final GlobalKey<FormState> formKey;

  @override
  _AdminBuildOnStepUpdateDialogState createState() => _AdminBuildOnStepUpdateDialogState();
}

class _AdminBuildOnStepUpdateDialogState extends State<AdminBuildOnStepUpdateDialog> {
  String _returningType = "";

  @override
  void initState() {
    super.initState();

    if (widget.buildOnStep != null) {
      _returningType = widget.buildOnStep.returningType;
    }
  }

  @override
  void didUpdateWidget(covariant AdminBuildOnStepUpdateDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.buildOnStep != null) {
      _returningType = widget.buildOnStep.returningType;
    }
  }
  @override
  Widget build(BuildContext context) {
    if (widget.buildOnStep == null) {
      return Container();
    }

    return BuCard(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text("Configurer l'étape", style: Theme.of(context).textTheme.headline5,),
                ),
                InkWell(
                  onTap: widget.onClosed,
                  child: const Icon(Icons.close, size: 32,)
                )
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: widget.formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BuImagePicker(
                      image: widget.buildOnStep.image,
                      onUpdated: widget.onUpdated,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BuTextInput(
                            controller: TextEditingController()..text = widget.buildOnStep.name, 
                            labelText: "Nom de l'étape", 
                            hintText: "Nom",
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Vous devez rentrer un nom";
                              }

                              return null;
                            },
                            onChanged: (value) => widget.onUpdated(),
                            onSaved: (value) => widget.buildOnStep.name = value
                          ),
                          const SizedBox(height: 10,),
                          BuTextInput(
                            controller: TextEditingController()..text = widget.buildOnStep.description, 
                            labelText: "Description", 
                            hintText: "Description",
                            inputType: TextInputType.multiline,
                            maxLines: 7,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Vous devez rentrer une description";
                              }

                              return null;
                            },
                            onChanged: (value) => widget.onUpdated(),
                            onSaved: (value) => widget.buildOnStep.description = value
                          ),
                          const SizedBox(height: 10,),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("étape actuelle".toUpperCase(), style: const TextStyle(fontSize: 14, color: Color(0xff919191)),),
                              const SizedBox(height: 10,),
                              BuDropdown<String>(
                                items: <String, String>{
                                  BuildOnReturningType.file: BuildOnReturningType.detailled[BuildOnReturningType.file],
                                  BuildOnReturningType.link: BuildOnReturningType.detailled[BuildOnReturningType.link],
                                  BuildOnReturningType.comment: BuildOnReturningType.detailled[BuildOnReturningType.comment],
                                },
                                currentValue: _returningType,
                                onChanged: (newValue) {
                                  widget.buildOnStep.returningType = newValue;
                                  setState(() {
                                    _returningType = newValue;
                                  });

                                  widget.onUpdated();
                                },
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 10,),
                          if (_returningType == BuildOnReturningType.link)
                            BuTextInput(
                              controller: TextEditingController()..text = widget.buildOnStep.returningLink, 
                              labelText: "URL du lien", 
                              hintText: "Lien",
                              inputType: TextInputType.url,
                              validator: (value) {
                                if (_returningType == BuildOnReturningType.link && value.isEmpty) {
                                  return "Vous devez rentrer un lien";
                                }

                                return null;
                              },
                              onChanged: (value) => widget.onUpdated(),
                              onSaved: (value) => widget.buildOnStep.returningLink = value
                            ),
                          const SizedBox(height: 10,),
                          BuTextInput(
                            controller: TextEditingController()..text = widget.buildOnStep.returningDescription, 
                            labelText: "Description des preuves à fournir", 
                            hintText: "Preuve",
                            inputType: TextInputType.multiline,
                            maxLines: 3,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Vous devez rentrer une description";
                              }

                              return null;
                            },
                            onChanged: (value) => widget.onUpdated(),
                            onSaved: (value) => widget.buildOnStep.returningDescription = value
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}