
import 'package:buildup/src/shared/dialogs/bu_modal_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/inputs/bu_textinput.dart';
import 'package:flutter/material.dart';

class BuildOnStepRefusingReason extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _reasonController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BuModalDialog(
      title: "Explication du refus", 
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
        text: "Refuser",
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
          BuTextInput(
            controller: _reasonController,
            labelText: "Raisons du refus", 
            hintText: "Raisons du refus",
            inputType: TextInputType.multiline,
            maxLines: 5,
            validator: (value) {
              if (value.isEmpty) {
                return "Vous devez rentrer une raison";
              }

              return null;
            },
          ),
        ],     
      ),
    );
  }

  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  } 

  void _save(BuildContext context) {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pop(_reasonController.text);
    }
  }
}