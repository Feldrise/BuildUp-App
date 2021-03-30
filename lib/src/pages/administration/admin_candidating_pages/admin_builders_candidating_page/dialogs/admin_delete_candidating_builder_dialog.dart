import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/shared/dialogs/bu_modal_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminDeleteCandidatingBuilderDialog extends StatelessWidget {
  const AdminDeleteCandidatingBuilderDialog({Key? key, required this.builder}) : super(key: key);

  final BuBuilder builder;

  @override
  Widget build(BuildContext context) {
    return BuModalDialog(
      title: "Supprimer la candidature",
      content: _buildDescription(),
      actions: _buildButtons(context),
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
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

  Widget _buildDescription() {
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
          Text(builder.associatedUser.fullName),
          const SizedBox(height: 8,),
          const Text("Projet :", style: TextStyle(fontWeight: FontWeight.w500),),
          const SizedBox(height: 5,),
          Text(builder.associatedProjects.first.name),
        ],        
      ),
    );
  } 
}