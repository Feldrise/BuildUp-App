import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/common/process_image.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CoachProcessSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoachStore>(
      builder: (context, coachStore, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                BuButton(
                  icon: Icons.download_rounded,
                  text: "Télécharger la fiche", 
                  onPressed: () async => launch("$kApiBaseUrl/../pdf/coachs/${coachStore.coach.id}.pdf"),
                ),
                BuButton(
                  icon: Icons.arrow_forward,
                  text: "Accéder à mon espace personnel",
                  buttonType: BuButtonType.secondary,
                  onPressed: () => _goToDashboard(context, coachStore),
                )
              ],
            ),
            const SizedBox(height: 24,),
            const Center(child: ProcessImage(imageName: "success"))
          ],
        );
      },
    );
  }

  Future _goToDashboard(BuildContext context, CoachStore coachStore) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Activation de votre espace..."); 

    try {
      final String authorization = coachStore.coach.associatedUser.authentificationHeader;

      coachStore.coach.status = CoachStatus.validated;
      coachStore.coach.step = CoachSteps.active;

      await coachStore.updateCoach(authorization, coachStore.coach);
      coachStore.notifyChange();
    } on Exception {
      // TODO: proper error message
      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
      return;
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
  }
}