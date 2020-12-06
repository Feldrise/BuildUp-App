import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/src/pages/administration/admin_buildons_page/widgets/admin_buildon_list_tile.dart';
import 'package:buildup/src/providers/buildons_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBuildOnsListView extends StatelessWidget {
  const AdminBuildOnsListView({
    Key key,
    @required this.buildOnRequestUpdate,
    @required this.activeBuildOn,
  }) : super(key: key);

  final Function(BuildOn) buildOnRequestUpdate;
  final BuildOn activeBuildOn;

  @override
  Widget build(BuildContext context) {
    return Consumer<BuildOnsStore>(
      builder: (context, buildOnsStore, child) {
        return ReorderableListView(
          scrollController: ScrollController(),
          onReorder: (oldIndex, newIndex) => buildOnsStore.reorder(oldIndex: oldIndex, newIndex: newIndex),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          children: [
            for (final buildOn in buildOnsStore.loadedBuildOns)
              GestureDetector(
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