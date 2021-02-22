import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/shared/dialogs/bu_modal_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminViewCandidatingBuilderDialog extends StatelessWidget {
  const AdminViewCandidatingBuilderDialog({Key key, @required this.builder}) : super(key: key);

  final BuBuilder builder;

  @override
  Widget build(BuildContext context) {
    return BuModalDialog(
      title: builder.associatedUser.fullName,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40,),
          buildTitle("Profil"),
          const SizedBox(height: 10,),
          Wrap(
            children: [
              buildSmallInfo("Nom", builder.associatedUser.fullName),
              buildSmallInfo("Date de naissance", DateFormat("dd/MM/yyyy").format(builder.associatedUser.birthdate)),
              buildSmallInfo("Département", builder.associatedUser.department.toString())
            ],
          ),
          const SizedBox(height: 10,),
          Wrap(
            children: [
              buildSmallInfo("Situation", builder.situation),
              buildSmallInfo("Tag Discord", builder.associatedUser.discordTag),
              buildSmallInfo("Email", builder.associatedUser.email)
            ],
          ),
          const SizedBox(height: 10,),
          buildBigInfo("Description :", builder.description),
          const SizedBox(height: 15,),
          buildTitle("Projet"),
          const SizedBox(height: 10,),
          Wrap(
            children: [
              buildSmallInfo("Nom", builder.associatedProjects.first.name),
              // TODO add categorie
              buildSmallInfo("Catégorie", "Application"),
              buildSmallInfo("Date de lancement", DateFormat("dd/MM/yyyy").format(builder.associatedProjects.first.launchDate)),
            ],
          ),
          const SizedBox(height: 10,),
          buildBigInfo("Description :", builder.associatedProjects.first.description),
          const SizedBox(height: 10,),
          buildBigInfo("Information générales : ", "TODO"),
          const SizedBox(height: 10,),
          buildBigInfo("Equipe :", builder.associatedProjects.first.team),
          const SizedBox(height: 15,),
          buildTitle("Réponses au formulaire"),
          for (final qa in builder.associatedForm.qas) ...{
            const SizedBox(height: 10,),
            buildBigInfo(qa.question, qa.answer),
          },
          const SizedBox(height: 60,),
        ],
      ),
      actions: _buildButtons(context)
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

  Widget buildSmallInfo(String title, String info) {
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

  Widget buildBigInfo(String title, String info) {
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

  Widget buildTitle(String title) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colorPrimary),)
      ),
    );
  }
}