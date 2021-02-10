import 'package:buildup/entities/coach.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/coach/coach_process_sucess.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/coach/coach_validated_candidature.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/common/process_image.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/process_widget.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidatingProcessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Consumer<UserStore>(
                builder: (context, userStore, child) {
                  if (userStore.user.role == UserRoles.builder) {
                    return _buildBuilderCandidatingProcess();
                  }
                  else if(userStore.user.role == UserRoles.coach) {
                    return _buildCoachCandidatingProcess();
                  }
                  else {
                    return const Center(child: Text("Vous n'avez pas de processus de candiature..."),);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuilderCandidatingProcess() {
    return const Center(child: Text("Builder process"));
  }

  Widget _buildCoachCandidatingProcess() {
    const int maxSteps = 5;
    return Consumer<CoachStore>(
      builder: (context, coachStore, child) {
        // The coach has been refused
        if (coachStore.coach.status == CoachStatus.deleted) {
          return const ProcessWidget(
            title: "Candidature refusée", 
            description: [
              Text("Votre candidature a malehreusement été refusée..."),
              Text("N’hésitez pas à vous rapprocher de l’équipe pour comprendre pourquoi !")
            ],
            index: 4, maxSteps: 4,
            child: ProcessImage(imageName: "refused",),
          );
        }

        // The coach just candidated
        if (coachStore.coach.step == CoachSteps.preselected) {
          return const ProcessWidget(
            title: "Candidature en cours d'examen", 
            description: [
              Text("Votre candidature est actuellement en cours d’examen."),
              Text("Nous reviendrons vers vous le plus vite possible afin de prendre contact.")
            ],
            index: 1, maxSteps: maxSteps,
            child: ProcessImage(imageName: "preselected",),
          );
        }

        // We fixed an appointment with the coach
        if (coachStore.coach.step == CoachSteps.meeting) {
          return ProcessWidget(
            title: "Une prise de contact a été effectuée", 
            description: [
              const Text("L’équipe a pris contact avec vous afin de convenir d’une date d’entretien."),
              RichText(
                text: TextSpan(
                  text: "Si vous n’avez pas été contacté, ",
                  style: Theme.of(context).textTheme.bodyText2,
                  children: const <TextSpan>[
                    TextSpan(text: 'merci de vous rapprocher de l’équipe New-Talents.', style: TextStyle(color: colorPrimary)),
                  ],
                ),
              )
            ],
            index: 2, maxSteps: maxSteps,
            child: const ProcessImage(imageName: "meeting",)
          );
        }

        // The meeting is done
        if (coachStore.coach.step == CoachSteps.meetingDone) {
          return const ProcessWidget(
            title: "Entretien réalisé", 
            description: [
              Text("L’entretien avec l’équipe New-Talents a été réalisé."),
              Text("Nous vous donnerons une réponse dès que possible.")
            ],
            index: 3, maxSteps: maxSteps,
            child: ProcessImage(imageName: "meeting_done"),
          );
        }

        // The coach need to sign
        if (!coachStore.coach.hasSignedFicheIntegration && coachStore.coach.step == CoachSteps.signing) {
          return ProcessWidget(
            title: "Candidature validée : édition carte et fiche d’intégration", 
            description: const [
              Text("Votre candidature a été validée."),
              Text("Vous pouvez dès à présent remplir votre fiche d’intégration et éditer votre carte."),
              Text("Pour finaliser votre inscription au programme pour une durée d’une année, lisez les documents présentés ci-dessous et n’oubliez pas de signer.")
            ],
            index: 4, maxSteps: maxSteps,
            child: CoachValidatedCandidature(onSigned: () => _signCoachIntegration(context, coachStore)),
          );
        }
        
        if (coachStore.coach.hasSignedFicheIntegration) {
          return ProcessWidget(
            title: "Candidature terminée", 
            description: const [
              Text("Votre canditature est officiellement terminée ! Bienvenue dans le programme !"),
              Text("Vous pouvez dès à présent télécharger votre carte ainsi que votre fiche d’intégration, puis accéder à votre espace personnel."),
            ],
            index: 5, maxSteps: maxSteps,
            child: CoachProcessSuccess()
          );
        }


        return const Center(child: Text("Etape inconnue..."));
      },
    );
  }

  Future _signCoachIntegration(BuildContext context, CoachStore coachStore) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Signature et génération du PDF en cours..."); 

    try {
      final String authorization = coachStore.coach.associatedUser.authentificationHeader;

      await coachStore.signIntegration(authorization);
    } on Exception {
      // TODO: proper error message
      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
      return;
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
  }
}