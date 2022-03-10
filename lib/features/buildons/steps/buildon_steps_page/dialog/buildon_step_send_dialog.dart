import 'package:buildup/core/widgets/dialogs/closable_dialog.dart';
import 'package:buildup/core/widgets/inputs/bu_textfield.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:buildup/features/project/proofs/proof.dart';
import 'package:flutter/material.dart';

class BuildOnStepSendDialog extends StatefulWidget {
  const BuildOnStepSendDialog({
    Key? key,
    required this.step
  }) : super(key: key);

  final BuildOnStep step;

  @override
  State<BuildOnStepSendDialog> createState() => _BuildOnStepSendDialogState();
}

class _BuildOnStepSendDialogState extends State<BuildOnStepSendDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClosableDialog(
      title: "Validation ${widget.step.name}",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The proof description
          Text("Demandé pour la validation d'étape :", style: TextStyle(color: Theme.of(context).primaryColor),),
          const SizedBox(height: 4,),
          Text(widget.step.proofDescription),
          const SizedBox(height: 20,),

          // The proof
          Text("Preuve :", style: TextStyle(color: Theme.of(context).primaryColor),),
          const SizedBox(height: 4,),
          Flexible(child: _buildInput())
        ],
      ),
      actions: [
        const SizedBox(height: 1,),
        ElevatedButton(
          onPressed: _sendProof, 
          child: const Text("Demander une validation")
        )
      ],
    );
  }

  Widget _buildInput() {
    return Form(
      key: _formKey,
      child: BuTextField(
        controller: _commentTextController,
        labelText: "Commentaire",
        hintText: "Veuillez rentrer le commentaire",
        inputType: TextInputType.multiline,
        maxLines: 3,
        validator: (value) {
          if (value.isEmpty) return "Vous devez rentrer un commentaire";
    
          return null;
        },
      ),
    );
  }

  void _sendProof() {
    // If we need to send a comment
    if (widget.step.proofType == BuildOnStepProofType.comment) {
      _sendCommentProof();
    }
  }

  void _sendCommentProof() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final Proof proof = Proof(null,
      stepID: widget.step.id!, 
      type: widget.step.proofType, 
      status: ProofStatus.waiting,
      comment: _commentTextController.text  
    );

    Navigator.of(context).pop(proof);
  }
}