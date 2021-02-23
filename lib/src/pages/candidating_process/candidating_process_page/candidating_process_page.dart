import 'package:buildup/entities/available_coach.dart';
import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/coach.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/builder/available_coach_widget/available_coach_widget.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/builder/builder_process_success.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/builder/builder_validated_candidature.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/coach/coach_process_success.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/coach/coach_validated_candidature.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/common/process_image.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/process_widget.dart';
import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidatingProcessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ScreenUtils.instance.horizontalPadding;

    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
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
    const int maxSteps = 7;

    return Consumer<BuilderStore>(
      builder: (context, builderStore, child) {
        // The builder has been refused
        if (builderStore.builder.status == BuilderStatus.deleted) {
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

        // The builder just candidated
        if (builderStore.builder.step == BuilderSteps.preselected) {
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
        if (builderStore.builder.step == BuilderSteps.adminMeeting) {
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
            // TODO: attestation mineur
            child: const ProcessImage(imageName: "meeting",)
          );
        }

        // The meeting is done
        if (builderStore.builder.step == BuilderSteps.adminMeetingDone) {
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

        // The builder has to choose his coach
        if (builderStore.builder.step == BuilderSteps.coachMeeting &&
            builderStore.builder.associatedCoach == null) {
          return ProcessWidget(
            title: "Candidature validée", 
            description: const [
              Text("Votre candidature a été validée."),
              Text("Vous pouvez dès maintenant choisir un coach et prendre contact avec lui avec les moyens de contact mis à votre disposition. Après avoir échangé avec lui, validez votre choix.")
            ],
            index: 4, maxSteps: maxSteps,
            child: AvailableCoachWidget(
              onCoachValidated: (coach) => _selectCoachForBuilder(context, builderStore, coach),
            ),
          );
        }

        // The builder waits for coach validation
        if (builderStore.builder.step == BuilderSteps.coachMeeting &&
            builderStore.builder.associatedCoach != null) {
          return const ProcessWidget(
            title: "En attente validation du coach", 
            description: [
              Text("La rencontre avec le coach a été réalisée."),
              Text("Nous vous donnerons une réponse dès que possible.")
            ],
            index: 5, maxSteps: maxSteps,
            child: ProcessImage(imageName: "waiting_coach"),
          );
        }

        // The builder need to sign
        if (!builderStore.builder.hasSignedFicheIntegration && builderStore.builder.step == BuilderSteps.signing) {
          return ProcessWidget(
            title: "Edition carte et fiche d’intégration", 
            description: const [
              Text("La rencontre avec le coach a été réalisée."),
              Text("Vous pouvez dès à présent remplir votre fiche d’intégration et éditer votre carte."),
              Text("Pour finaliser votre inscription au programme pour une durée de 3 mois, lisez les documents présentés ci-dessous et n’oubliez pas de signer.")
            ],
            index: 6, maxSteps: maxSteps,
            child: BuilderValidatedCandidature(onSigned: () => _signBuilderIntegration(context, builderStore)),
          );
        }

        // The builder is at the end of the process
        if (builderStore.builder.hasSignedFicheIntegration) {
          return ProcessWidget(
            title: "Candidature terminée", 
            description: const [
              Text("Votre canditature est officiellement terminée ! Bienvenue dans le programme !"),
              Text("Vous pouvez dès à présent télécharger votre carte ainsi que votre fiche d’intégration, puis accéder à votre espace personnel."),
            ],
            index: 7, maxSteps: maxSteps,
            child: BuilderProcessSuccess()
          );
        }


        return const Center(child: Text("Etape inconnue..."));
      },
    );
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
        
        // The coach is at the end of the process
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
  
  Future _signBuilderIntegration(BuildContext context, BuilderStore builderStore) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Signature et génération du PDF en cours..."); 

    try {
      final String authorization = builderStore.builder.associatedUser.authentificationHeader;

      await builderStore.signIntegration(authorization);
    } on Exception {
      // TODO: proper error message
      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
      return;
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
  }

  Future _selectCoachForBuilder(BuildContext context, BuilderStore builderStore, AvailableCoach availableCoach) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.showLoadingDialog(context, keyLoader, "Validation du coach..."); 

    try {
      final String authorization = builderStore.builder.associatedUser.authentificationHeader;

      await builderStore.assignCoach(authorization, availableCoach.id);
    } on Exception {
      // TODO: proper error message
      Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
      return;
    }

    Navigator.of(keyLoader.currentContext,rootNavigator: true).pop();
  }
}