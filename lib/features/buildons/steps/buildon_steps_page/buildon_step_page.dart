import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/features/buildons/buildon.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_page/widget/buildon_detail.dart';
import 'package:buildup/features/buildons/steps/buildon_steps_page/widget/buildon_step_stepper_detail.dart';
import 'package:buildup/features/buildons/widgets/buildon_locked_detail.dart';
import 'package:buildup/features/buildons/widgets/stepper_step.dart';
import 'package:buildup/features/project/project.dart';
import 'package:buildup/features/project/proofs/proof.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';

class BuildOnStepPage extends StatefulWidget {
  const BuildOnStepPage({
    Key? key,
    required this.buildOn,
    required this.project,
  }) : super(key: key);

  final BuildOn buildOn;
  final Project project;

  @override
  State<BuildOnStepPage> createState() => _BuildOnStepPageState();
}

class _BuildOnStepPageState extends State<BuildOnStepPage> {
  final Map<String, Proof> _proofs = {};

  void _initialize() {
    for (final proof in widget.project.proofs!) {
      _proofs[proof.stepID] = proof;
    }
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant BuildOnStepPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.buildOn.name),
      ),
      body: SingleChildScrollView(
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
              // The buildon infos
              Flexible(child: BuildOnDetail(buildOn: widget.buildOn,)),

              // The stepper
              Flexible(child: _buildStepper())
            ], 
          ),
        ),
      ),
    );
  }

  Widget _buildStepper() {
    final List<StepperStep> steps = _stepperStep();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final step in steps) 
          Flexible(child: step)
      ],
    );
  }

  List<StepperStep> _stepperStep() {
    final List<StepperStep> result = [];

    for (int i = 0; i < widget.buildOn.steps.length; ++i) {
      final step = widget.buildOn.steps[i];
      final bool isLast = i == widget.buildOn.steps.length - 1;
      final bool isCompleted = _proofs[step.id]?.status == ProofStatus.completed;
      final bool isWaitingForValidation = _proofs[step.id]?.status == ProofStatus.waiting;

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
        child: BuildOnStepStepperDetail(step: step, associatedProof: _proofs[step.id],),
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
}