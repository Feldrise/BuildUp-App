import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/features/buildons/buildon.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_page/widget/buildon_detail.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_page/widget/buildon_step_stepper_detail.dart';
import 'package:buildup/features/buildons/widgets/buildon_locked_detail.dart';
import 'package:buildup/features/buildons/widgets/stepper_step.dart';
import 'package:buildup/features/project/project_graphql.dart';
import 'package:buildup/features/project/proofs/proof.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/users_graphql.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BuildOnStepPage extends StatefulWidget {
  const BuildOnStepPage({
    Key? key,
    required this.buildOn,
    this.builderId,
  }) : super(key: key);

  final BuildOn buildOn;
  final String? builderId;

  @override
  State<BuildOnStepPage> createState() => _BuildOnStepPageState();
}

class _BuildOnStepPageState extends State<BuildOnStepPage> {
  String _statusMessage = "";
  bool _isSuccessfull = true;
  bool _shouldRefetch = false;

  QueryOptions<dynamic> _userOptions() {
    return QueryOptions<dynamic>(
      document: gql(qGetUserWithProofs),
      variables: <String, dynamic>{
        "id": widget.builderId
      }
    );
  }

  MutationOptions<dynamic> _submitProofMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(qMutSubmitProof),
      onError: (error) {
        _isSuccessfull = false;
        _statusMessage = "Nous n'arrivons pas à soumettre votre preuve...";
        _shouldRefetch = false; 
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        _isSuccessfull = true;
        _statusMessage = "Votre preuve a bien été envoyé !";
        _shouldRefetch = true;
      }
    );
  } 

  MutationOptions<dynamic> _valudateProofMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(qMutValidateProof),
      onError: (error) {
        _isSuccessfull = false;
        _statusMessage = "Nous n'arrivons pas à accépter la preuve...";
        _shouldRefetch = false; 
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        _isSuccessfull = true;
        _statusMessage = "La preuve a bien été refusé";
        _shouldRefetch = true;
      }
    );
  } 

  MutationOptions<dynamic> _refuseProofMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(qMutRefuseProof),
      onError: (error) {
        _isSuccessfull = false;
        _statusMessage = "Nous n'arrivons pas à refuser la preuve...";
        _shouldRefetch = false; 
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        _isSuccessfull = true;
        _statusMessage = "La preuve a bien été refusé";
        _shouldRefetch = true;
      }
    );
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.buildOn.name),
      ),
      body: Mutation<dynamic>(
        options: _submitProofMutationOptions(),
        builder: (submitRunMutation, submitMutationResult) {
          return Mutation<dynamic>(
            options: _valudateProofMutationOptions(),
            builder: (validateRunMutation, validateMutationResult) {
              return Mutation<dynamic>(
                options: _refuseProofMutationOptions(),
                builder: (refuseRunMutation, refuseMutationResult) {
                  return Query<dynamic>(
                    options: _userOptions(),
                    builder: (userResult, {fetchMore, refetch}) {
                      if (_shouldRefetch && refetch != null) {
                        refetch();
                        _shouldRefetch = false;
                      }

                      if (
                        (submitMutationResult?.isLoading ?? false) || 
                        (validateMutationResult?.isLoading ?? false) || 
                        (refuseMutationResult?.isLoading ?? false) || 
                        userResult.isLoading
                      ) {
                        return const Center(child: CircularProgressIndicator(),);
                      }

                      if (userResult.hasException) {
                        return const Align(
                        alignment: Alignment.topLeft,
                          child: BuStatusMessage(
                            message: "Nous n'arrivons pas à charger les informations utilisateur .",
                          ),
                        );
                      }
                      
                      final User user = User.fromJson(userResult.data?["user"] as Map<String, dynamic>? ?? <String, dynamic>{});
                      final Map<String, Proof> proofs = _proofsToMap(user.builder!.project!.proofs!);
                    
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: ScreenUtils.instance.horizontalPadding,
                            right: ScreenUtils.instance.horizontalPadding,
                            top: 30,
                          ),
                          constraints: const BoxConstraints(maxWidth: 850),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // We may show a message if needed
                              if (_statusMessage.isNotEmpty) ...{
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: ScreenUtils.instance.horizontalPadding
                                  ),
                                  child: BuStatusMessage(
                                    type: _isSuccessfull ? BuStatusMessageType.success : BuStatusMessageType.error,
                                    message: _statusMessage,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              },

                              // The buildon infos
                              Flexible(child: BuildOnDetail(buildOn: widget.buildOn,)),

                              // The stepper
                              Flexible(
                                child: _buildStepper(
                                  proofs, 
                                  user.builder!.project!.id!, 
                                  submitRunMutation,
                                  refuseRunMutation,
                                  validateRunMutation,
                                )
                              )
                            ], 
                          ),
                        ),
                      );
                    }
                  );
                }
              );
            }
          );
        }
      ),
    );
  }

  Widget _buildStepper(
    Map<String, Proof> proofs, 
    String projectID, 
    RunMutation submitProofRunMutation,
    RunMutation refuseProofRunMutation,
    RunMutation validateProofRunMutation,
  ) {
    final List<StepperStep> steps = _stepperStep(
      proofs, 
      projectID, 
      submitProofRunMutation,
      refuseProofRunMutation,
      validateProofRunMutation,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final step in steps) 
          Flexible(child: step)
      ],
    );
  }

  List<StepperStep> _stepperStep(
    Map<String, Proof> proofs, 
    String projectID, 
    RunMutation submitProofRunMutation, 
    RunMutation refuseProofRunMutation,
    RunMutation validateRunMutation,
  ) {
    final List<StepperStep> result = [];

    for (int i = 0; i < widget.buildOn.steps.length; ++i) {
      final step = widget.buildOn.steps[i];
      final bool isLast = i == widget.buildOn.steps.length - 1;
      final bool isCompleted = proofs[step.id]?.status == ProofStatus.completed;
      final bool isWaitingForValidation = proofs[step.id]?.status == ProofStatus.waiting;

      StepperStepState state = StepperStepState.waiting;

      if (isCompleted) {
        state = StepperStepState.validated;
      }
      else if (isWaitingForValidation) {
        state = StepperStepState.waitingValidation;
      }

      result.add(StepperStep(
        index: i + 1,
        isLast: isLast,
        state: state,
        child: BuildOnStepStepperDetail(
          step: step, 
          associatedProof: proofs[step.id], 
          projectID: projectID, 
          submitProofRunMutation: submitProofRunMutation,
          refuseProofRunMutation: refuseProofRunMutation,
          validateProofRunMutation: validateRunMutation,
          isBuilder: widget.builderId == null,
        ),
        previousColor: i > 0 ? Palette.colorSuccess : null,
      ));

      // We need the break confition
      if ((isWaitingForValidation || !isCompleted) && !isLast) {
        result.add(StepperStep(
          index: i + 1,
          isLast: true,
          state: StepperStepState.locked,
          child: const BuildOnLockedDetail(),
          previousColor: isWaitingForValidation ? Palette.colorWarning : Palette.colorInfo,
        ));

        break;
      }
    }

    return result;
  }

  Map<String, Proof> _proofsToMap(List<Proof> proofs) {
    final Map<String, Proof> result = {};

    for (final proof in proofs) {
      result[proof.stepID] = proof;
    }

    return result;
  }
}