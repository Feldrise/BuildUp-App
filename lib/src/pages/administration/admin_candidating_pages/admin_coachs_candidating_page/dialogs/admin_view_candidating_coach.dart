import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/shared/dialogs/bu_modal_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminViewCandidatingCoachDialog extends StatelessWidget {
  const AdminViewCandidatingCoachDialog({Key? key, required this.coach}) : super(key: key);

  final Coach coach;

  @override
  Widget build(BuildContext context) {
    return BuModalDialog(
      title: coach.associatedUser.fullName,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40,),
          _buildTitle("Profil"),
          const SizedBox(height: 10,),
          Wrap(
            children: [
              _buildSmallInfo("Nom", coach.associatedUser.fullName),
              _buildSmallInfo("Date de naissance", DateFormat("dd/MM/yyyy").format(coach.associatedUser.birthdate)),
              _buildSmallInfo("Département", coach.associatedUser.department.toString())
            ],
          ),
          const SizedBox(height: 10,),
          Wrap(
            children: [
              _buildSmallInfo("Situation", coach.situation),
              _buildSmallInfo("Tag Discord", coach.associatedUser.discordTag ?? "Inconnue"),
              _buildSmallInfo("Email", coach.associatedUser.email)
            ],
          ),
          const SizedBox(height: 10,),
          _buildBigInfo("Description :", coach.description),
          const SizedBox(height: 15,),
          if (coach.associatedForm != null) ...{
            _buildTitle("Réponses au formulaire"),
            for (final qa in coach.associatedForm!.qas) ...{
              const SizedBox(height: 10,),
              _buildBigInfo(qa.question, qa.answer),
            },
            const SizedBox(height: 60,),
          },
        ],
      ),
      actions: _buildButtons(context),
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    return [
      BuButton(
        buttonType: BuButtonType.secondary,
        text: "Retour",
        onPressed: () => Navigator.pop(context, false),
        isBig: true,
      ),
      Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children: [
          BuButton(
            buttonType: BuButtonType.secondary,
            icon: Icons.picture_as_pdf,
            text: "Exporter en PDF", 
            onPressed: () {},
            isBig: true,
          ),
          BuButton(
            text: "Valider",
            onPressed: () => Navigator.pop(context, true),
            isBig: true,
          )
        ],
      )
    ];
  }

  Widget _buildSmallInfo(String title, String info) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: const TextStyle(fontSize: 14, color: Color(0xff919191)),),
          const SizedBox(height: 5,),
          Text(info)
        ],  
      ),
    );
  } 

  Widget _buildBigInfo(String title, String info) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 7,),
            Text(info)
          ],  
        ),
      ),
    );
  } 

  Widget _buildTitle(String title) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colorPrimary),)
      ),
    );
  }
}