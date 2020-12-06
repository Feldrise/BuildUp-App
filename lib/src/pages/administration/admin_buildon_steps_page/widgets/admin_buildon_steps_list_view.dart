
import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/pages/administration/admin_buildon_steps_page/widgets/admin_buildon_step_list_tile.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:flutter/material.dart';

class AdminBuildOnStepsListView extends StatelessWidget {
  const AdminBuildOnStepsListView({
    Key key,
    @required this.buildOn,
    @required this.buildOnStepRequestUpdate,
    @required this.activeBuildOnStep,
    @required this.onUpdated,
  }) : super(key: key);

  final BuildOn buildOn;

  final Function(BuildOnStep) buildOnStepRequestUpdate;
  final BuildOnStep activeBuildOnStep;

  final Function() onUpdated;

  @override
  Widget build(BuildContext context) {
    if (buildOn.steps.isEmpty) {
      return const BuStatusMessage(
        type: BuStatusMessageType.info,
        title: "Liste vide",
        message: "Il n'y a actuellement aucun étape. Créez-en une !",
      );
    }

    return ReorderableListView(
      scrollController: ScrollController(),
      onReorder: (oldIndex, newIndex) {
        buildOn.reorderStep(oldIndex: oldIndex, newIndex: newIndex);
        onUpdated();
      },
      children: [
        for (final buildOnStep in buildOn.steps)
          GestureDetector(
            key: ValueKey(buildOnStep),
            onTap: () => buildOnStepRequestUpdate(buildOnStep),
            child: AdminBuildOnStepListTile(
              buildOnStep: buildOnStep,
              isActive: buildOnStep == activeBuildOnStep,
            ),
          )
      ],
    );
  }
}