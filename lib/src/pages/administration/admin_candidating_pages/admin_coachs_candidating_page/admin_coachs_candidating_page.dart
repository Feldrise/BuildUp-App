import 'package:buildup/services/coachs_services.dart';
import 'package:buildup/src/pages/administration/admin_candidating_pages/admin_coachs_candidating_page/widgets/admin_candidating_coachs_card.dart';
import 'package:buildup/src/providers/candidating_coachs_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminCoachsCandidatingPage extends StatelessWidget {
  const AdminCoachsCandidatingPage({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: Stack(
        children: [
          ListView(), // Here to make the RefreshIndicator working
          Consumer<CandidatingCoachsStore>(
            builder: (context, candidatingCoachsStore, child) {
              if (!candidatingCoachsStore.hasData) {
                return const Center(
                  child: BuStatusMessage(
                    type: BuStatusMessageType.info,
                    message: "Il n'y a aucun coach candidatant pour le moment",
                  ),
                );
              }
              
              return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final coach in candidatingCoachsStore.coachs) 
                      AdminCandidatingCoachCard(coach: coach,)
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // TODO : handle errors
  Future<void> _refresh(BuildContext context) async {
    final CandidatingCoachsStore candidatingBuilderStore = Provider.of<CandidatingCoachsStore>(context, listen: false);
    final UserStore currentUser = Provider.of<UserStore>(context, listen: false);

    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Rafraîchissement des candiatures coachs"); 

    candidatingBuilderStore.clear();
    candidatingBuilderStore.coachs = await CoachsService.instance.getCandidatingCoach(currentUser.authentificationHeader);

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
  }
}