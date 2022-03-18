import 'dart:convert';

import 'package:buildup/core/widgets/dialogs/closable_dialog.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:buildup/features/project/proofs/proof.dart';
import 'package:buildup/features/users/users_graphql.dart';
import 'package:buildup/theme/palette.dart';
import 'package:download/download.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

class BuildOnStepValidationDialog extends StatefulWidget {
  const BuildOnStepValidationDialog({
    Key? key,
    required this.step,
    required this.proof
  }) : super(key: key);
  
  final BuildOnStep step;
  final Proof proof;

  @override
  State<BuildOnStepValidationDialog> createState() => _BuildOnStepValidationDialogState();
}

class _BuildOnStepValidationDialogState extends State<BuildOnStepValidationDialog> {
  bool _isDownloadingFile = false;

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
    // If comment we just show a text
    if (widget.proof.type == BuildOnStepProofType.comment) {
      return Text(
        widget.proof.comment!
      );
    }

    if (widget.proof.type == BuildOnStepProofType.file) {
      if (_isDownloadingFile) {
        return const Text(
          "Téléchargement en cours...",
          style: TextStyle(fontStyle: FontStyle.italic),
        );
      }

      return  InkWell(
        onTap: () => _onDownloadFile(context),
        child: Row(
          children: [
            Text(widget.proof.file?.filename ?? "Fichier corrompu", style: const TextStyle(decoration: TextDecoration.underline,),),
            const SizedBox(width: 10,),
            const Icon(Icons.file_download, size: 16,)
          ],
        ),
      );
    
    }

    return Container();
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

  Future _onDownloadFile(BuildContext context) async {
    setState(() {
      _isDownloadingFile = true;
    });

    final GraphQLClient client = GraphQLProvider.of(context).value;

    final proofData = await client.query<dynamic>(
      QueryOptions<dynamic>(
        document: gql(qProofWithFile),
        variables: <String, dynamic>{
          "id": widget.proof.id
        }
      )
    );

    final Proof downloadedProof = Proof.fromJson(
      proofData.data!["proof"] as Map<String, dynamic>
    );


    if (downloadedProof.file != null) {
      final stream = Stream.fromIterable(base64Decode(downloadedProof.file!.base64content!));
      
      if (kIsWeb) {
        html.AnchorElement()
          ..href = "data:application/octet-stream;charset=utf-16le;base64,${downloadedProof.file!.base64content}"
          ..setAttribute("download", downloadedProof.file!.filename)
          ..click();
      } else {
        final String downloadPath = (await getDownloadsDirectory())?.path ?? "/";
        final String fileName = downloadedProof.file!.filename;

        await download(stream, "$downloadPath/$fileName");
      }
    }

    setState(() {
      _isDownloadingFile = false;
    });
  }
}