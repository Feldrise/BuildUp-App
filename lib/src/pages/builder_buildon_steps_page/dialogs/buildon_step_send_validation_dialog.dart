
import 'package:buildup/entities/buildons/buildon_returning.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/shared/dialogs/bu_modal_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_checkbox.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_file_picker.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_text_field.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildOnStepSendValidationDialog extends StatefulWidget {
  const BuildOnStepSendValidationDialog({
    Key key, 
    @required this.buildOnStep,
    this.buildOnReturning,
  }) : super(key: key);

  final BuildOnStep buildOnStep;
  final BuildOnReturning buildOnReturning;
  @override
  _BuildOnStepSendValidationDialogState createState() => _BuildOnStepSendValidationDialogState();
}

class _BuildOnStepSendValidationDialogState extends State<BuildOnStepSendValidationDialog> {
  bool _canSend = false;

  @override
  Widget build(BuildContext context) {
    return BuModalDialog(
      title: "Validation ${widget.buildOnStep.name}",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Demandé pour la validation de l'étape", style: TextStyle(color: colorPrimary)),
          const SizedBox(height: 20,),
          Text(widget.buildOnStep.returningDescription),
          const SizedBox(height: 30,),
          const Text("Preuve :", style: TextStyle(color: colorPrimary)),
          const SizedBox(height: 10,),
          _buildProofField(),
        ],
      ),
      actions: [
        _buildButtons(context)
      ],
    );
  }

  Widget _buildProofField() {
    if (widget.buildOnStep.returningType == BuildOnReturningType.file) {
      return BuFilePicker(
        file: widget.buildOnReturning.file,
        onUpdated: () {
          setState(() {
            _canSend = true;
          });
        },
      );
    }

    if (widget.buildOnStep.returningType == BuildOnReturningType.comment) {
      return BuTextField(
        controller: TextEditingController()..text = widget.buildOnReturning.comment, 
        labelText: "Commentaire",
        hintText: "Commentaire", 
        inputType: TextInputType.multiline,
        maxLines: 5,
        onChanged: (value) {
          widget.buildOnReturning.comment = value;

          if (value.isEmpty) {
            setState(() {
              _canSend = false;
            });
          }
          else if (!_canSend) {
            setState(() {
              _canSend = true;
            });
          }
        }
      );
    }

    if (widget.buildOnStep.returningType == BuildOnReturningType.link) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async => launch(widget.buildOnStep.returningLink),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.link, size: 16, color: Theme.of(context).textTheme.bodyText1.color),
                const SizedBox(width: 5,),
                Text(
                  widget.buildOnStep.returningLink,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15,),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xfff5f5f6),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: const Color(0xffedeff0),
              )
            ),
            child: BuCheckBox(
              value: _canSend,
              text: "Je confirme avoir rempli ma preuve via le lien présenté ci-dessus.",
              onChanged: (value) {
                setState(() {
                  _canSend = value;
                });
              },
            ),
          )
        ],
      );
    }

    return const Text("Aucune entrée n'est possible, veuillez en informer votre Coach");
  } 

  Widget _buildButtons(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: BuButton(
        text: "Demander une validation",
        onPressed: _canSend ? () => Navigator.pop(context, true) : null,
      ),
    );
  }
}