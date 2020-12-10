
import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/entities/buildons/buildon_returning.dart';
import 'package:buildup/entities/buildons/buildon_step.dart';
import 'package:buildup/src/shared/widgets/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/bu_stepper.dart';
import 'package:buildup/src/shared/widgets/buildons/buildon_step_card.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminBuildOnStepActiveBuilderPage extends StatelessWidget {
  const AdminBuildOnStepActiveBuilderPage({
    Key key,
    @required this.builder,
    @required this.buildOn  
  }) : super(key: key);
  
  final BuBuilder builder;
  final BuildOn buildOn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      appBar: BuAppBar(
        title: Text("${buildOn.name} de ${builder.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final List<BuildOnStep> buildOnSteps = buildOn.steps;
              final List<BuStepperChild> stepperChildren = _buildStepperChildren(buildOnSteps, isSmall: constraints.maxWidth <= 500);

              return Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: BuStepper(
                    children: stepperChildren,
                    showLocked: stepperChildren.length != buildOnSteps.length
                  ),
                ),
              );
            },
          )
        )
      ),
    );
  }

  List<BuStepperChild> _buildStepperChildren(List<BuildOnStep> buildOnSteps, {bool isSmall}) {
    final List<BuStepperChild> result = [];

    final String currentBuildOnStep = builder.associatedProjects.first.currentBuildOnStep ?? buildOnSteps.first.id;

    for (final buildOnStep in buildOnSteps) {
      final BuildOnReturning returning = builder.associatedProjects.first.associatedReturnings[buildOnStep.id];
      Color color = const Color(0xff17ba63);

      if (returning == null) {
        color = const Color(0xff36a2b1);
      }
      else if (returning.status == BuildOnReturningStatus.waiting) {
        color = const Color(0xfff4bd2a);
      }

      result.add(
        BuStepperChild(
          widget: BuildOnStepCard(
            buildOnStep: buildOnStep,
            buildOnReturning: returning,
            isSmall: isSmall,
          ),
          color: color
        )
      );

      if (buildOnStep.id == currentBuildOnStep || returning?.status == BuildOnReturningStatus.waiting) {
        break;
      }
    }

    return result;
  }
}