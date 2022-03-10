import 'package:buildup/core/widgets/dialogs/closable_dialog.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:buildup/features/project/proofs/proof.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

class BuildOnStepValidationDialog extends StatelessWidget {
  const BuildOnStepValidationDialog({
    Key? key,
    required this.step,
    required this.proof
  }) : super(key: key);
  
  final BuildOnStep step;
  final Proof proof;

  @override
  Widget build(BuildContext context) {
    return ClosableDialog(
      title: "Validation ${step.name}",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The proof description
          Text("Demandé pour la validation d'étape :", style: TextStyle(color: Theme.of(context).primaryColor),),
          const SizedBox(height: 4,),
          Text(step.proofDescription),
          const SizedBox(height: 20,),

          // The proof
          Text("Preuve :", style: TextStyle(color: Theme.of(context).primaryColor),),
          const SizedBox(height: 4,),
          Flexible(child: _buildResult())
        ]
      ),
      actions: [
        const SizedBox(height: 1,),
        _buildButton(context) 
      ],
    );
  }

  Widget _buildResult() {
    return Text(
      proof.comment!
    );
  }

  Widget _buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Refuse button
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Theme.of(context).primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(false), 
          child: Row(
            children: const [
              Icon(Icons.close, size: 16,),
              SizedBox(width: 4,),
              Text("Refuser l'étape"),
            ]
          ),
        ),
        const SizedBox(width: 20,),

        // Validate button
        // Refuse button
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: Palette.colorSuccess,
            side: const BorderSide(color: Palette.colorSuccess),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(true), 
          child: Row(
            children: const [
              Icon(Icons.check, size: 16,),
              SizedBox(width: 4,),
              Text("Valider l'étape"),
            ]
          ),
        )
      ],
    );
  }
}