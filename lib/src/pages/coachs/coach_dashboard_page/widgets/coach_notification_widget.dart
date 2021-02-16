import 'package:buildup/entities/notification/coach_request.dart';
import 'package:buildup/src/pages/coachs/coach_dashboard_page/widgets/coach_request_card.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoachNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoachStore>(
      builder: (context, coachStore, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Actualités", style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 16,),
            if (coachStore.coach.associatedRequest?.isEmpty) 
              const Text("Vous n'avez pas de nouvelle demande de builder")
            else 
              for (final coachRequest in coachStore.coach.associatedRequest) 
                CoachRequestCard(
                  request: coachRequest, 
                  onAccepted: () => _acceptCoachRequest(context, coachStore, coachRequest), 
                  onRefused: () => _refuseCoachRequest(context, coachStore, coachRequest)
                )
          ],
        );
      },
    );
  }

  Future _acceptCoachRequest(BuildContext context, CoachStore coachStore, CoachRequest coachRequest) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Acceptation de la demande..."); 

    try {
      final String authorization = coachStore.coach.associatedUser.authentificationHeader;

      await coachStore.acceptCoachRequest(authorization, coachRequest);
    } on Exception {
      // TODO: proper error message
      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
      return;
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
  }

  Future _refuseCoachRequest(BuildContext context, CoachStore coachStore, CoachRequest coachRequest) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Acceptation de la demande..."); 

    try {
      final String authorization = coachStore.coach.associatedUser.authentificationHeader;

      await coachStore.refuseCoachRequest(authorization, coachRequest);
    } on Exception {
      // TODO: proper error message
      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
      return;
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
  }
}