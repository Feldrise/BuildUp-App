
import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminNtfReferentDeleteDialog extends StatelessWidget {
  const AdminNtfReferentDeleteDialog({Key? key, required this.ntfReferent}) : super(key: key);

  final NtfReferent ntfReferent;

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
                  child: Text("Supprimer le référent", style: Theme.of(context).textTheme.headline4,)
                ),
                InkWell(
                  onTap: () => Navigator.pop(context, false),
                  child: const Icon(Icons.close, size: 28,),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            const Divider(),
            const SizedBox(height: 30,),
            const Text("Souhaitez-vous vraiment supprimer le référent ?", style: TextStyle(color: colorPrimary)),
            const SizedBox(height: 20,),
            buildDescription(),
            const SizedBox(height: 40,),
            if (MediaQuery.of(context).size.width > 476) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buildButtons(context),
            ) else Column(
              mainAxisSize: MainAxisSize.min,
              children: buildButtons(context),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildButtons(BuildContext context) {
    return [
      BuButton(
        buttonType: BuButtonType.secondary,
        text: "Annuler",
        onPressed: () => Navigator.pop(context, false),
        isBig: true,
      ),
      BuButton(
        icon: Icons.delete,
        text: "Supprimer",
        onPressed: () => Navigator.pop(context, true),
        isBig: true,
      )
    ];
  }

  Widget buildDescription() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 240,
      decoration: BoxDecoration(
        color: colorScaffoldGrey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nom :", style: TextStyle(fontWeight: FontWeight.w500),),
          const SizedBox(height: 5,),
          Text(ntfReferent.name),
          const SizedBox(height: 8,),
          const Text("Email :", style: TextStyle(fontWeight: FontWeight.w500),),
          const SizedBox(height: 5,),
          Text(ntfReferent.email),
        ],        
      ),
    );
  } 
}