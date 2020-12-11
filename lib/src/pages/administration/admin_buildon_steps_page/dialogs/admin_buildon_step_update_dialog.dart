import 'package:buildup/entities/buildons/buildon_returning.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/shared/widgets/bu_card.dart';
import 'package:buildup/src/shared/widgets/bu_dropdown.dart';
import 'package:buildup/src/shared/widgets/bu_image_picker.dart';
import 'package:buildup/src/shared/widgets/bu_text_field.dart';
import 'package:flutter/material.dart';

class AdminBuildOnStepUpdateDialog extends StatefulWidget {
  const AdminBuildOnStepUpdateDialog({
    Key key,
    @required this.buildOnStep,
    @required this.onUpdated,
    @required this.onClosed
  }) : super(key: key);

  final BuildOnStep buildOnStep;

  final Function() onUpdated;
  final Function() onClosed;

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
                GestureDetector(
                  onTap: widget.onClosed,
                  child: const Icon(Icons.close, size: 32,)
                )
              ],
            ),
          ),
          Expanded(
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
                        BuTextField(
                          controller: TextEditingController()..text = widget.buildOnStep.name, 
                          labelText: "Nom de l'étape", 
                          hintText: "Nom",
                          onChanged: (value) {
                            widget.buildOnStep.name = value;
                            widget.onUpdated();
                          }
                        ),
                        const SizedBox(height: 10,),
                        BuTextField(
                          controller: TextEditingController()..text = widget.buildOnStep.description, 
                          labelText: "Description", 
                          hintText: "Description",
                          inputType: TextInputType.multiline,
                          maxLines: 3,
                          onChanged: (value) {
                            widget.buildOnStep.description = value;
                            widget.onUpdated();
                          }
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
                          BuTextField(
                            controller: TextEditingController()..text = widget.buildOnStep.returningLink, 
                            labelText: "URL du lien", 
                            hintText: "Lien",
                            inputType: TextInputType.url,
                            onChanged: (value) {
                              widget.buildOnStep.returningLink = value;
                              widget.onUpdated();
                            }
                          ),
                        const SizedBox(height: 10,),
                        BuTextField(
                          controller: TextEditingController()..text = widget.buildOnStep.returningDescription, 
                          labelText: "Description des preuves à fournir", 
                          hintText: "Preuve",
                          inputType: TextInputType.multiline,
                          maxLines: 3,
                          onChanged: (value) {
                            widget.buildOnStep.returningDescription = value;
                            widget.onUpdated();
                          }
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}