
import 'package:buildup/entities/buildons/buildon_returning.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/shared/widgets/bu_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class BuildOnStepProcessValidationDialog extends StatelessWidget {
  const BuildOnStepProcessValidationDialog({
    Key key, 
    @required this.buildOnStep,
    this.buildOnReturning,
    this.onDownload
    
  }) : super(key: key);

  final BuildOnStep buildOnStep;
  final BuildOnReturning buildOnReturning;
  final Function() onDownload;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 50),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: const Border(
            top: BorderSide(
              width: 4,
              color: colorPrimary
            )
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text("Validation ${buildOnStep.name}", style: Theme.of(context).textTheme.headline4,)
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 28,),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            const Divider(),
            const SizedBox(height: 30,),
            const Text("Demandé pour la validation de l'étape", style: TextStyle(color: colorPrimary)),
            const SizedBox(height: 20,),
            Text(buildOnStep.returningDescription),
            const SizedBox(height: 30,),
            const Text("Document reçu", style: TextStyle(color: colorPrimary)),
            _buildReceivedDocument(),
            const SizedBox(height: 20,),
            const SizedBox(height: 30),
            Wrap(
              spacing: 40,
              alignment: WrapAlignment.spaceAround,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: BuButton(
                    buttonType: BuButtonType.outlineRed,
                    icon: Icons.close,
                    text: "Refuser l'étape",
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: BuButton(
                    buttonType: BuButtonType.outlineGreen,
                    icon: Icons.check,
                    text: "Valider l'étape",
                    onPressed: () => Navigator.pop(context, true),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReceivedDocument() {
    if (buildOnReturning == null) {
      return const Text("Aucun rendu n'a actuellement été fournis à cette étape", style: TextStyle(fontStyle: FontStyle.italic));
    }

    if (buildOnReturning.type == BuildOnReturningType.file) {
      return  GestureDetector(
        onTap: onDownload,
        child: Row(
          children: [
            Text(buildOnReturning.fileName, style: const TextStyle(decoration: TextDecoration.underline,),),
            const SizedBox(width: 10,),
            const Icon(Icons.file_download, size: 16,)
          ],
        ),
      );
    }

    if (buildOnReturning.type == BuildOnReturningType.comment) {
      return Text(buildOnReturning.comment);
    }

    if (buildOnReturning.type == BuildOnReturningType.link) {
      return const Text("Le rendu de cette étape est externe", style: TextStyle(fontStyle: FontStyle.italic));
    }

    return const Text("Le type de rendu est inconnue...", style: TextStyle(fontStyle: FontStyle.italic));
  } 
}