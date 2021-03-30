import 'package:buildup/entities/meeting_report.dart';
import 'package:buildup/src/shared/dialogs/bu_modal_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_date_form_field.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_textinput.dart';
import 'package:flutter/material.dart';

class CreateMeetingReportDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _objectifTextController = TextEditingController();
  final TextEditingController _evolutionController = TextEditingController();
  final TextEditingController _whatsNextController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  final MeetingReport _meetingReport = MeetingReport(
    null,
    date: DateTime.now(),
    nextMeetingDate: DateTime.now(),
  ); 

  @override
  Widget build(BuildContext context) {
    return BuModalDialog(
      title: "Nouveau rapport", 
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildForm(context),
        ],
      ), 
      actions: _buildButtons(context)
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    return [
      BuButton(
        text: "Annuler",      
        buttonType: BuButtonType.secondary,
        isBig: true,
        onPressed: () => _cancel(context)
      ),
      BuButton(
        icon: Icons.save,
        text: "Enregistrer",
        isBig: true,
        onPressed: () => _save(context),
      )
    ];
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextArea(
            description: "Objectifs de l’entretien",
            editingController: _objectifTextController,
            onSaved: (value) => _meetingReport.objectif = value
          ),
          _buildTextArea(
            description: "Evolutions constatées",
            editingController: _evolutionController,
            onSaved: (value) => _meetingReport.evolution = value
          ),
          _buildTextArea(
            description: "Perspectives avant le prochain entretien",
            editingController: _whatsNextController,
            onSaved: (value) => _meetingReport.whatsNext = value
          ),
          _buildTextArea(
            description: "Commentaires",
            editingController: _commentsController,
            onSaved: (value) => _meetingReport.comments = value
          ),
          const SizedBox(height: 16),
          BuDateFormField(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 1000)),
            initialValue: DateTime.now(),
            label: "Date prévue pour le prochain entretien",
            validator: (value) {
              if (value == null) {
                return "Une date est obligatoire";
              }

              return null;
            },
            onChanged: (value) {
              _meetingReport.nextMeetingDate = value;
            },
          )
        ],     
      ),
    );
  }

  Widget _buildTextArea({required String description, required TextEditingController editingController, required Function(String) onSaved}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BuTextInput(
        controller: editingController,
        labelText: description, 
        hintText: description,
        inputType: TextInputType.multiline,
        maxLines: 5,
        validator: (value) {
          if (value.isEmpty) {
            return "Vous devez rentrer une valeur";
          }

          return null;
        },
        onSaved: onSaved,
      ),
    );
  }

  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  } 

  void _save(BuildContext context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _meetingReport.date = DateTime.now();

      Navigator.of(context).pop(_meetingReport);
    }
  }
}