import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminViewCandidatingCoachDialog extends StatelessWidget {
  const AdminViewCandidatingCoachDialog({Key key, @required this.coach}) : super(key: key);

  final Coach coach;

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
                  child: Text(coach.associatedUser.fullName, style: Theme.of(context).textTheme.headline4,)
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context, false),
                  child: const Icon(Icons.close, size: 28,),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40,),
                    buildTitle("Profil"),
                    const SizedBox(height: 10,),
                    Wrap(
                      children: [
                        buildSmallInfo("Nom", coach.associatedUser.fullName),
                        buildSmallInfo("Date de naissance", DateFormat("dd/MM/yyyy").format(coach.associatedUser.birthdate)),
                        buildSmallInfo("Département", coach.department.toString())
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Wrap(
                      children: [
                        buildSmallInfo("Situation", coach.situation),
                        buildSmallInfo("Tag Discord", coach.associatedUser.discordTag),
                        buildSmallInfo("Email", coach.associatedUser.email)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    buildBigInfo("Description :", coach.description),
                    const SizedBox(height: 15,),
                    buildTitle("Réponses au formulaire"),
                    for (final qa in coach.associatedForm.qas) ...{
                      const SizedBox(height: 10,),
                      buildBigInfo(qa.question, qa.answer),
                    },
                    const SizedBox(height: 60,),
                  ],
                ),
              ),
            ),
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
        text: "Retour",
        onPressed: () => Navigator.pop(context, false),
        isBig: true,
      ),
      const SizedBox(width: 8.0, height: 8.0,),
      Wrap(
        children: [
          BuButton(
            buttonType: BuButtonType.secondary,
            icon: Icons.picture_as_pdf,
            text: "Exporter en PDF", 
            onPressed: () {},
            isBig: true,
          ),
          const SizedBox(width: 20,),
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