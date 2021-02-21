
import 'package:buildup/entities/available_coach.dart';
import 'package:buildup/src/shared/dialogs/bu_modal_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AvailableCoachDialog extends StatelessWidget {
  const AvailableCoachDialog({Key key, @required this.coach}) : super(key: key);

  final AvailableCoach coach;

  @override
  Widget build(BuildContext context) {
    return BuModalDialog(
      title: "Informations sur ${coach.fullName}", 
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDescription(context),
        ],
      ), 
      actions: _buildButtons(context)
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    return [
      Container(),
      BuButton(
        text: "Valider",
        isBig: true,
        onPressed: () => Navigator.pop(context),
      )
    ];
  }

  Widget _buildDescription(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              _buildProfileWidget(context),
              _buildContactWidget(coach.email, coach.discordTag)
            ],
          ),
          const SizedBox(height: 16,),
          _buildBigInfo("Description", coach.description),
          _buildBigInfo("Compétences :", coach.competences),
          if (coach.questions.length != coach.answers.length) 
            const BuStatusMessage(
              title: "Erreur",
              message: "Impossible d'afficher les réponses du coach...",
            )
          else 
            for (int i = 0; i < coach.questions.length; ++i)
              _buildBigInfo(coach.questions[i], coach.answers[i])
        ],     
      ),
    );
  } 

  Widget _buildProfileWidget(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Row(
        children: [
          Center(
            child: SizedBox(
              width: 48,
              height: 48,
              child: BuImageWidget(
                image: coach.profilePicture,
                isCircular: true,
              ),
            ),
          ),
          const SizedBox(width: 8,),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coach.fullName, style: Theme.of(context).textTheme.headline6,),
                Text(coach.situation, style: const TextStyle(color: colorGreyText))
              ],
            ),
          )  
        ],
      ),
    );
  }

  
  Widget _buildContactWidget(String email, String discordTag) {
    return SizedBox(
      width: 250,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.mail, size: 15,),
              const SizedBox(width: 5,),
              Expanded(
                child: InkWell(
                  onTap: () {
                    launch('mailto:$email');
                  },
                  child: Text(email, style: const TextStyle(color: colorPrimary))
                ),
              )
            ],
          ),
          Row(
            children: [
              const Icon(Icons.switch_account, size: 15,),
              const SizedBox(width: 5,),
              Expanded(
                child: Text(discordTag)
              )
            ],
          )
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
}