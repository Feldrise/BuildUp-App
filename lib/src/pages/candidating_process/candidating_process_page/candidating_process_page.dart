import 'package:buildup/entities/coach.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/common/process_image.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/widgets/process_widget.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidatingProcessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
    );
  }

  Widget _buildBuilderCandidatingProcess() {
    return const Center(child: Text("Builder process"));
  }

  Widget _buildCoachCandidatingProcess() {
    const int maxSteps = 7;
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


        return const Center(child: Text("Etape inconnue..."));
      },
    );
  }
}