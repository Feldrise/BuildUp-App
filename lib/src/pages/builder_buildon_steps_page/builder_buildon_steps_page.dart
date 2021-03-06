
import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/entities/buildons/buildon_returning.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/pages/builder_buildon_steps_page/widgets/buildon_step_buildon.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/general/bu_stepper.dart';
import 'package:buildup/src/pages/builder_buildon_steps_page/widgets/buildon_step_card.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class BuilderBuildOnStepsPage extends StatelessWidget {
  const BuilderBuildOnStepsPage({
    Key? key,
    required this.builder,
    required this.buildOn,
    this.nextBuildOn,  
  }) : super(key: key);
  
  final BuBuilder builder;
  final BuildOn? nextBuildOn;

  final BuildOn buildOn;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ScreenUtils.instance.horizontalPadding;

    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      appBar: BuAppBar(
        title: Text("${buildOn.name} de ${builder.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5,),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: BuildOnStepBuildOn(buildOn: buildOn)
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final List<BuildOnStep> buildOnSteps = buildOn.steps;
                    final List<BuStepperChild> stepperChildren = _buildStepperChildren(buildOnSteps, isSmall: constraints.maxWidth <= 500);

                    return Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: BuStepper(
                          children: stepperChildren,
                          showLocked: stepperChildren.length != buildOnSteps.length
                        ),
                      ),
                    );
                  },
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  List<BuStepperChild> _buildStepperChildren(List<BuildOnStep> buildOnSteps, {required bool isSmall}) {
    final List<BuStepperChild> result = [];

    final String currentBuildOnStep = builder.associatedProjects.first.currentBuildOnStep ?? buildOnSteps.first.id!;

    for (final buildOnStep in buildOnSteps) {
      final BuildOnReturning? returning = builder.associatedProjects.first.associatedReturnings[buildOnStep.id];
      Color color = const Color(0xff17ba63);

      if (returning == null) {
        color = const Color(0xff36a2b1);
      }
      else if (returning.status == BuildOnReturningStatus.waiting ||
               returning.status == BuildOnReturningStatus.waitingCoach ||
               returning.status == BuildOnReturningStatus.waitingAdmin) {
        color = const Color(0xfff4bd2a);
      }


      result.add(
        BuStepperChild(
          widget: BuildOnStepCard(
            buildOnStep: buildOnStep,
            buildOnReturning: returning,
            project: builder.associatedProjects.first,
            isSmall: isSmall,
            nextBuildOn: buildOnSteps.last.id == buildOnStep.id && nextBuildOn != null ? nextBuildOn!.id! : buildOn.id!,
            nextBuildOnStep: buildOnSteps.last.id == buildOnStep.id ? nextBuildOn?.steps.first.id! : buildOnSteps[buildOnSteps.indexOf(buildOnStep) + 1].id,
          ),
          color: color
        )
      );

      if (buildOnStep.id == currentBuildOnStep || 
          returning?.status == BuildOnReturningStatus.waiting ||
          returning?.status == BuildOnReturningStatus.waitingCoach ||
          returning?.status == BuildOnReturningStatus.waitingAdmin) {
        break;
      }
    }

    return result;
  }
}