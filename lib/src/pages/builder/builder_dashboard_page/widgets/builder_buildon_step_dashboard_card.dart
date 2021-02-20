
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/services/buildons_service.dart';
import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuilderBuildOnDashboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BuilderStore>(
      builder: (context, builderStore, child) {
        return BuCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Mon avancée Build-On", style: Theme.of(context).textTheme.headline6,),
              const SizedBox(height: 15,),
              Flexible(child: _buildCoachInfos(builderStore)),
              const SizedBox(height: 15,),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCoachInfos(BuilderStore builderStore) {
    return FutureBuilder(
      future: BuildOnsService.instance.getBuildOnStep(
        builderStore.builder.associatedUser.authentificationHeader,
        builderStore.builder.associatedProjects.first.currentBuildOnStep
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text("Impossible de récupérer l'étape actuelle..."),);
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("Vous n'en êtes à aucune étape..."),);
          }

          final BuildOnStep currentStep = snapshot.data as BuildOnStep;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 4,
                child: BuImageWidget(
                  image: currentStep.image,
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: Text(currentStep.name, style: Theme.of(context).textTheme.headline5,)),
                    const SizedBox(height: 4,),
                    Flexible(child: Text("${currentStep.description.substring(0, 80)}..."))
                  ],
                ),
              )
            ],
          );
        }

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 84,
                height: 84,
                child: CircularProgressIndicator()
              ),
              SizedBox(height: 30,),
              Text("Récupération des informations...")
            ]
          ),
        );
      },
    );
  }
}