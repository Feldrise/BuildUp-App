import 'package:buildup/entities/available_coach.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/builder/available_coach_widget/available_coach_dialog.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AvailableCoachCard extends StatelessWidget {
  const AvailableCoachCard({
    Key key, 
    @required this.coach,
    this.isSelected = false,
    this.width,
    @required this.onCoachSelected,
  }) : super(key: key);

  final AvailableCoach coach;
  final bool isSelected;

  final double width;

  final Function(AvailableCoach) onCoachSelected;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      width: width,
      borderColor: isSelected ? colorPrimary : null,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
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
          const SizedBox(height: 8,),
          Text(coach.fullName, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6,),
          Text(coach.situation, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: colorGreyText)),
          const SizedBox(height: 24),
          _buildContactWidget(coach.email, coach.discordTag),
          const SizedBox(height: 24),
          BuButton(
            icon: Icons.info_outline,
            text: "Plus d'informations", 
            buttonType: BuButtonType.secondaryGrey,
            onPressed: () => _showMoreInfo(context)
          ),
          const SizedBox(height: 8,),
          BuButton(
            text: "Choisir le coach",
            buttonType: BuButtonType.secondary,
            onPressed: () => onCoachSelected(coach),
          ),
        ],
      )
    );
  }

  Widget _buildContactWidget(String email, String discordTag) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(Icons.mail, size: 15,),
            const SizedBox(width: 5,),
            Expanded(
              child: GestureDetector(
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
    );
  }

  Future _showMoreInfo(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      builder: (context) => AvailableCoachDialog(coach: coach)
    );
  }

}