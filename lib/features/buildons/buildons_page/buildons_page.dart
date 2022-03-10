import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/bu_status_message.dart';
import 'package:buildup/features/buildons/buildon.dart';
import 'package:buildup/features/buildons/buildons_graphql.dart';
import 'package:buildup/features/buildons/buildons_page/widgets/buildon_stepper_detail.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_page/buildon_step_page.dart';
import 'package:buildup/features/buildons/widgets/buildon_locked_detail.dart';
import 'package:buildup/features/buildons/widgets/stepper_step.dart';
import 'package:buildup/features/project/project.dart';
import 'package:buildup/features/project/proofs/proof.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/users_graphql.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BuildOnsPage extends ConsumerWidget {
  const BuildOnsPage({
    Key? key,
    this.builderId,
  }) : super(key: key);

  final String? builderId;

  QueryOptions<Map<String, dynamic>> _userOptions() {
    return QueryOptions<Map<String, dynamic>>(
      document: gql(qGetUserWithProofs),
      variables: <String, dynamic>{
        "id": builderId
      }
    );
  }

  QueryOptions<dynamic> _buildOnsOption() {
    return QueryOptions<dynamic>(
      document: gql(qBuildOns)
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // First, we need to get the connected user
    return Query<Map<String, dynamic>>(
      options: _userOptions(),
      builder: (loggedResult, {fetchMore, refetch}) {
        if (loggedResult.isLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (loggedResult.hasException) {
          return const Align(
            alignment: Alignment.topLeft,
            child: BuStatusMessage(
              message: "Nous n'arrivons pas à charger les informations utilisateur. Cette erreur ne devrait pas arriver, n'hésitez pas à nous contacter.",
            ),
          );
        }
  
        final User user = User.fromJson(loggedResult.data?["user"] as Map<String, dynamic>? ?? <String, dynamic>{});

        return Scaffold(
          appBar: builderId == null ? null : AppBar(
            title: Text("Build-Ons de ${user.firstName} ${user.lastName}"),
          ),
          body: Query<dynamic>(
            options: _buildOnsOption(),
            builder: (buildOnsResult, {fetchMore, refetch}) {
              if (buildOnsResult.isLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }

              if (buildOnsResult.hasException) {
                return const Align(
                  alignment: Alignment.topLeft,
                  child: BuStatusMessage(
                    message: "Nous n'arrivons pas à charger les build-Ons.",
                  ),
                );
              }
              
              final List mapsBuildOns = buildOnsResult.data!["buildons"] as List;
              final List<BuildOn> buildOns = [];

              for (final map in mapsBuildOns) {
                buildOns.add(BuildOn.fromJson(map as Map<String, dynamic>));
              }

              final Map<String, List<Proof>> validatedProofMap = _createValidatedProofMap(user.builder!.project!.proofs!, buildOns);

              return _buildContent(context, buildOns, validatedProofMap, user.builder!.project!);
            },
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, List<BuildOn> buildOns, Map<String, List<Proof>> validatedProofs, Project project) {
    final List<StepperStep> steps = _stepperStep(context, buildOns, validatedProofs, project);

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.only(
          top: 30,
          left: ScreenUtils.instance.horizontalPadding,
          right: ScreenUtils.instance.horizontalPadding,
        ),
        constraints: const BoxConstraints(maxWidth: 825),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final step in steps) 
              Flexible(child: step)
          ],
        ),
      ),
    );
  }

  List<StepperStep> _stepperStep(BuildContext context, List<BuildOn> buildOns, Map<String, List<Proof>> validatedProofs, Project project) {
    final List<StepperStep> result = [];

    for (int i = 0; i < buildOns.length; ++i) {
      final buildOn = buildOns[i];
      final bool isCompleted = _isBuildOnCompleted(buildOn, validatedProofs);
      final bool isLast = i == buildOns.length - 1;

      StepperStepState state = StepperStepState.waiting;

      if (isCompleted) {
        state = StepperStepState.validated;
      }

      result.add(StepperStep(
        index: i + 1,
        isLast: isLast,
        state: state,
        child: InkWell(
          onTap: () => _openBuildOn(context, buildOn, project),
          child: BuildOnStepperDetail(buildOn: buildOn)
        ),
        previousColor: i > 0 ? Palette.colorSuccess : null,
      ));

      // We need to break the loop and show the lock
      // if the build-on is not completed or last
      if (!isCompleted && !isLast) {
        result.add(StepperStep(
          index: i + 1,
          isLast: true,
          state: StepperStepState.locked,
          child: const BuildOnLockedDetail(),
          previousColor: Palette.colorInfo,
        ));

        break;
      }
    }

    return result;
  }

  Map<String, List<Proof>> _createValidatedProofMap(List<Proof> proofs, List<BuildOn> buildOns) {
    final Map<String, List<Proof>> result = {};

    for (final buildOn in buildOns) {
      result[buildOn.id!] = [];
      for (final proof in proofs) {

        for (final step in buildOn.steps) {
          if (proof.status == ProofStatus.completed && proof.stepID == step.id) {
            result[buildOn.id!]!.add(proof);
          } 
        }
      }
    }

    return result;
  }

  bool _isBuildOnCompleted(BuildOn buildOn, Map<String, List<Proof>> validatedProof) {
    return buildOn.steps.length == validatedProof[buildOn.id]?.length;
  }

  Future _openBuildOn(BuildContext context, BuildOn buildOn, Project project) async {
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => BuildOnStepPage(buildOn: buildOn, builderId: builderId,),
      )
    );
  }
}