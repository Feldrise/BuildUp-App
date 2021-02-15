
import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/common/process_image.dart';
import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BuilderProcessSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BuilderStore>(
      builder: (context, builderStore, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuButton(
                  icon: Icons.download_rounded,
                  text: "Télécharger la fiche", 
                  onPressed: () async => launch("$kApiBaseUrl/../pdf/builders/${builderStore.builder.id}.pdf"),
                ),
                const SizedBox(width: 8,),
                BuButton(
                  icon: Icons.arrow_forward,
                  text: "Accéder à mon espace personnel",
                  buttonType: BuButtonType.secondary,
                  onPressed: () => _goToDashboard(context, builderStore),
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

  Future _goToDashboard(BuildContext context, BuilderStore builderStore) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Activation de votre espace..."); 

    try {
      final String authorization = builderStore.builder.associatedUser.authentificationHeader;

      builderStore.builder.status = BuilderStatus.validated;
      builderStore.builder.step = BuilderSteps.active;

      await builderStore.updateBuilder(authorization, builderStore.builder);
      builderStore.notifyChange();

    } on Exception {
      // TODO: proper error message
      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
      return;
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
  }
}