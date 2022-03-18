import 'dart:convert';
import 'dart:typed_data';

import 'package:buildup/core/models/bu_file.dart';
import 'package:buildup/core/widgets/dialogs/closable_dialog.dart';
import 'package:buildup/core/widgets/inputs/bu_textfield.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:buildup/features/project/proofs/proof.dart';
import 'package:file_picker/file_picker.dart';
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

  Uint8List? _uploadFile;
  String? _fileName;

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
    if (widget.step.proofType == BuildOnStepProofType.comment) {
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

    if (widget.step.proofType == BuildOnStepProofType.file) {
      return Row(
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Theme.of(context).primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
            ),
            onPressed: _pickFile,
            child: Row(
              children: const [
                Icon(Icons.file_upload_outlined),
                SizedBox(width: 8,),

                Text("Choisir un fichier")
              ],
            ),
          ),
          const SizedBox(width: 12,),

          if (_fileName != null)
            Text(_fileName!, style: const TextStyle(fontStyle: FontStyle.italic),),
        ],
      );
    }

    return Container();
  }

  void _sendProof() {
    // If we need to send a comment
    if (widget.step.proofType == BuildOnStepProofType.comment) {
      _sendCommentProof();
    }
    // If we need to send a file
    else if (widget.step.proofType == BuildOnStepProofType.file) {
      _sendFileProof();
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

  void _sendFileProof() {
    if (_uploadFile == null || _fileName == null) return;

    final Proof proof = Proof(null,
      stepID: widget.step.id!, 
      type: widget.step.proofType, 
      status: ProofStatus.waiting,
      file: BuFile(
        filename: _fileName!,
        base64content: base64Encode(_uploadFile!)
      )
    );

    Navigator.of(context).pop(proof);
  }

  Future _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true
    );

    if (result != null) {
      setState(() {
        _uploadFile = result.files.first.bytes;
        _fileName = result.files.first.name;
      });
    }
  }
}