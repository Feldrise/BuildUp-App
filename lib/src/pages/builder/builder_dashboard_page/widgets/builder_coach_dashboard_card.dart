import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BuilderCoachDashboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BuilderStore>(
      builder: (context, builderStore, child) {
        return BuCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Mon Coach", style: Theme.of(context).textTheme.headline6,),
              const SizedBox(height: 15,),
              Flexible(child: _buildCoachInfos(builderStore)),
              const SizedBox(height: 15,),
              Flexible(child: _buildEmailWidget(builderStore)),
              Flexible(child: _buildeDiscordWidget(builderStore),)
            ],
          ),
        );
      },
    );
  }

  Widget _buildCoachInfos(BuilderStore builderStore) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
         SizedBox(
            width: 48,
            height: 48,
            child: BuImageWidget(
              image: builderStore.builder.associatedCoach.associatedUser.profilePicture,
              isCircular: true,
            ),
          ),
          const SizedBox(width: 10,),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Flexible(
                  child: Text("COACH ASSIGNE", style: TextStyle(color: colorGreyText, fontSize: 14)),
                ),
                const SizedBox(height: 4,),
                Flexible(
                  child: Text(builderStore.builder.associatedCoach.associatedUser.fullName),
                )
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildEmailWidget(BuilderStore builderStore) {
    final String email = builderStore.builder.associatedCoach.associatedUser.email;

    return Row(
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
    );
  }

  Widget _buildeDiscordWidget(BuilderStore builderStore) {
    return Row(
      children: [
        const Icon(Icons.switch_account, size: 15,),
        const SizedBox(width: 5,),
        Expanded(
          child: Text(builderStore.builder.associatedCoach.associatedUser.discordTag)
        )
      ],
    );
  }
}