
import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/pages/administration/admin_buildon_steps_page/widgets/admin_buildon_step_list_tile.dart';
import 'package:buildup/src/providers/buildons_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBuildOnStepsListView extends StatelessWidget {
  const AdminBuildOnStepsListView({
    Key? key,
    required this.buildOn,
    required this.buildOnStepRequestUpdate,
    required this.activeBuildOnStep,
    required this.onUpdated,
  }) : super(key: key);

  final BuildOn buildOn;

  final Function(BuildOnStep) buildOnStepRequestUpdate;
  final BuildOnStep? activeBuildOnStep;

  final Function() onUpdated;

  @override
  Widget build(BuildContext context) {
    if (buildOn.steps.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BuStatusMessage(
            type: BuStatusMessageType.info,
            title: "Liste vide",
            message: "Il n'y a actuellement aucun étape. Créez-en une !",
          ),
          Expanded(
            child: Container(),
          )
        ],
      );
    }

    return ReorderableListView(
      scrollController: ScrollController(),
      onReorder: (oldIndex, newIndex) {
        buildOn.reorderStep(oldIndex: oldIndex, newIndex: newIndex);
        Provider.of<BuildOnsStore>(context, listen: false).buildonUpdated();
        onUpdated();
      },
      children: [
        for (int i = 0; i < buildOn.steps.length; ++i)
          InkWell(
            key: ValueKey(buildOn.steps[i]),
            onTap: () => buildOnStepRequestUpdate(buildOn.steps[i]),
            child: AdminBuildOnStepListTile(
              buildOnStep: buildOn.steps[i],
              index: i + 1,
              isActive: buildOn.steps[i] == activeBuildOnStep,
            ),
          )
      ],
    );
  }
}