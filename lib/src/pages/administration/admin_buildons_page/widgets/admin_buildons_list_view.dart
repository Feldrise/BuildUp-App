import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/src/pages/administration/admin_buildons_page/widgets/admin_buildon_list_tile.dart';
import 'package:buildup/src/providers/buildons_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBuildOnsListView extends StatelessWidget {
  const AdminBuildOnsListView({
    Key key,
    @required this.buildOnRequestUpdate,
    @required this.activeBuildOn,
    @required this.onUpdated,
  }) : super(key: key);

  final Function(BuildOn) buildOnRequestUpdate;
  final BuildOn activeBuildOn;

  final Function() onUpdated;

  @override
  Widget build(BuildContext context) {
    return Consumer<BuildOnsStore>(
      builder: (context, buildOnsStore, child) {
        if (buildOnsStore.loadedBuildOns.isEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const BuStatusMessage(
                type: BuStatusMessageType.info,
                title: "Liste vide",
                message: "Il n'y a actuellement aucun Build-On. Créez-en un !",
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
            buildOnsStore.reorder(oldIndex: oldIndex, newIndex: newIndex);
            onUpdated();
          },
          children: [
            for (final buildOn in buildOnsStore.loadedBuildOns)
              InkWell(
                key: ValueKey(buildOn),
                onTap: () => buildOnRequestUpdate(buildOn),
                child: AdminBuildOnListTile(
                  buildOn: buildOn,
                  isActive: buildOn == activeBuildOn,
                ),
              )
          ],
        );
      },
    );
  }
}