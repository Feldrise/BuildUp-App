import 'dart:convert';

import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/features/authentication/authentication_graphql.dart';
import 'package:buildup/features/buildons/steps/buildon_step.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_page/dialog/buildon_step_send_dialog.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_page/dialog/buildon_step_validation_dialog.dart';
import 'package:buildup/features/project/proofs/proof.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';

class BuildOnStepStepperDetail extends StatelessWidget {
  const BuildOnStepStepperDetail({
    Key? key,
    required this.step,
    required this.projectID,
    required this.submitProofRunMutation,
    required this.refuseProofRunMutation,
    required this.validateProofRunMutation,
    required this.isBuilder,
    this.associatedProof,
  }) : super(key: key);

  final BuildOnStep step;
  final String projectID;
  final Proof? associatedProof;

  final bool isBuilder;

  final RunMutation submitProofRunMutation;
  final RunMutation refuseProofRunMutation;
  final RunMutation validateProofRunMutation;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Row(
        children: [
          // The image
          Flexible(
            flex: 3,
            child: Container(
              color: Palette.colorLightGrey3,
            ),
          ),
          const SizedBox(width: 12,),
    
          // The info
          Flexible(
            flex: 7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // The title
                _buildHeader(context),
                const SizedBox(height: 12,),
    
                // The description
                Flexible(child: Text(step.description)),
                const SizedBox(height: 12,),

                // The message 
                _buildStatusMessage(),
                const SizedBox(height: 12,),

                // The button if needed
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _buildButton(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusMessage() {
    if (associatedProof == null) {
      return BuStatusMessage(
        type: BuStatusMessageType.info,
        title: "Comment valider l'étape ?",
        message: step.proofDescription,
      );
    }

    if (associatedProof!.status != ProofStatus.completed) {
      return Container();
    }

    final String message = associatedProof!.type == BuildOnStepProofType.comment 
      ? associatedProof!.comment!
      : "Un fichier a été envoyé";

    return BuStatusMessage(
      type: BuStatusMessageType.success,
      title: "Documents envoyés",
      message: message,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // The title
        Expanded(
          child: Text(step.name, style: Theme.of(context).textTheme.headline5,),
        ),

        // The indicator
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    if (associatedProof?.status == ProofStatus.completed) {
      return Row(
        children: const [
          // The icon
          Icon(Icons.check_circle, size: 18, color: Palette.colorSuccess,),
          SizedBox(width: 4,),

          // the text
          Text("Validé", style: TextStyle(color: Palette.colorSuccess),)
        ],
      );
    }

    if (associatedProof?.status.contains(ProofStatus.waiting) ?? false) {
      return Row(
        children: const [
          // The icon
          Icon(Icons.watch_later, size: 18, color: Palette.colorWarning,),
          SizedBox(width: 4,),

          // the text
          Text("En attendre de validation", style: TextStyle(color: Palette.colorWarning),)
        ],
      );
    }


    return Row(
      children: const [
        // The icon
        Icon(Icons.build, size: 18, color: Palette.colorInfo,),
        SizedBox(width: 4,),

        // the text
        Text("En cours", style: TextStyle(color: Palette.colorInfo),)
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    if (associatedProof == null && isBuilder) {
      return TextButton(
        onPressed: () => _openSendProofDialog(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("Demander une validation d'étape"),
            SizedBox(width: 8,),
            Icon(Icons.chevron_right)
          ],
        ),
      );
    }

    if (!isBuilder && (associatedProof?.status.contains(ProofStatus.waiting) ?? false)) {
      if (associatedProof?.status == ProofStatus.waiting) {
        return _buildValidateButton(context);
      }

      return Query<dynamic>(
        options: QueryOptions<dynamic>(
          document: gql(qGetLoggedUser),
        ),
        builder: (result, {fetchMore, refetch}) {
          final User appUser = User.fromJson(result.data?["user"] as Map<String, dynamic>? ?? <String, dynamic>{});

          if (appUser.role == UserRoles.admin && associatedProof?.status == ProofStatus.waitingAdmin) {
            return _buildValidateButton(context);
          }
          
          if (appUser.role == UserRoles.coach && associatedProof?.status == ProofStatus.waitingCoach) {
            return _buildValidateButton(context);
          }

          return Container();
        }
      );
    }

    return Container();
  }

  Widget _buildValidateButton(BuildContext context) {
    return TextButton(
      onPressed: () => _openValidateProofDialog(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text("Voir la preuve à valider"),
          SizedBox(width: 8,),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }

  Future _openSendProofDialog(BuildContext context) async {
    final Proof? proof = await showDialog<Proof>(
      context: context, 
      builder: (context) => BuildOnStepSendDialog(step: step)
    );

    if (proof != null) {
      submitProofRunMutation(<String, dynamic>{
        "projectID": projectID,
        "stepID": step.id,
        "type": proof.type,
        "comment": proof.comment,
        if (proof.file != null)
          "file": MultipartFile.fromBytes(
            "file",
            base64Decode(proof.file!.base64content!),
            filename: proof.file!.filename
          )
      });
    }
  }

  Future _openValidateProofDialog(BuildContext context) async {
    final bool? validate = await showDialog<bool?>(
      context: context,
      builder: (context) => BuildOnStepValidationDialog(
        step: step, 
        proof: associatedProof!,
      ) 
    );

    if (validate == null) return;

    if (validate) {
      validateProofRunMutation(<String, dynamic>{
        "proofID": associatedProof?.id
      });
    } 
    else {
      refuseProofRunMutation(<String, dynamic>{
        "proofID": associatedProof?.id
      });
    }
  }
}