import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_coachs_page/widgets/admin_active_coach_card.dart';
import 'package:buildup/src/providers/active_coachs_store.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminActiveCoachsPage extends StatelessWidget {
  const AdminActiveCoachsPage({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveCoachsStore>(
      builder: (context, activeCoachsStore, child) {
        if (!activeCoachsStore.hasData) {
          return const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: BuStatusMessage(
                type: BuStatusMessageType.info,
                message: "Il n'y a aucun coach actif pour le moment",
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (final coach in activeCoachsStore.coachs) 
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: AdminActiveCoachCard(
                          coach: coach,
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