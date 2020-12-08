
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_builders_page/widgets/admin_active_builder_card.dart';
import 'package:buildup/src/providers/active_builers_store.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminActiveBuildersPage extends StatelessWidget {
  const AdminActiveBuildersPage({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveBuildersStore>(
      builder: (context, activeBuildersStore, child) {
        if (!activeBuildersStore.hasData) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: BuStatusMessage(
              type: BuStatusMessageType.info,
              message: "Il n'y a aucun builder actif pour le moment",
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(30),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                children: [
                  for (final builder in activeBuildersStore.builders) 
                    AdminActiveBuilderCard(
                      builder: builder,
                      width: constraints.maxWidth > 500 ? 250 : constraints.maxWidth,
                    )
                ],
              );
            },
          )
        );
      }, 
    );
  }
}