
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
          return const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: BuStatusMessage(
                type: BuStatusMessageType.info,
                message: "Il n'y a aucun builder actif pour le moment",
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (final builder in activeBuildersStore.builders) 
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: AdminActiveBuilderCard(
                          builder: builder,
                          width: constraints.maxWidth > 500 ? 250 : constraints.maxWidth,
                        ),
                      )
                  ],
                ),
              );
            },
          )
        );
      }, 
    );
  }
}