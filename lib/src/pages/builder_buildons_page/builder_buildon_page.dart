import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/src/pages/builder_buildon_steps_page/builder_buildon_steps_page.dart';
import 'package:buildup/src/providers/buildons_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/general/bu_notification_dot.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/general/bu_stepper.dart';
import 'package:buildup/src/pages/builder_buildons_page/widgets/buildon_card.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuilderBuildOnsPage extends StatelessWidget {
  const BuilderBuildOnsPage({Key key, @required this.builder}) : super(key: key);
  
  final BuBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<BuildOnsStore>(
      builder: (context, buildOnsStore, child) {
        return Scaffold(
          backgroundColor: colorScaffoldGrey,
          appBar: BuAppBar(
            title: Text("Build-Ons de ${builder.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5,),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: FutureBuilder(
              future: buildOnsStore.buildons(Provider.of<UserStore>(context).authentificationHeader),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(
                      child: BuStatusMessage(
                        title: "Erreur lors de la récupération des builds-ons",
                        message: snapshot.error?.toString(),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final List<BuildOn> buildOns = snapshot.data as List<BuildOn>;
                        final List<BuStepperChild> stepperChildren = _buildStepperChildren(context, buildOns, isSmall: constraints.maxWidth <= 500);

                        return Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 1200),
                            child: BuStepper(
                              children: stepperChildren,
                              showLocked: stepperChildren.length != buildOns.length
                            ),
                          ),
                        );
                      },
                    )
                  );
                }

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(
                          width: 84,
                          height: 84,
                          child: CircularProgressIndicator()
                        ),
                        SizedBox(height: 30,),
                        Text("Récupération des build-ons")
                      ]
                    ),
                  ),
                );
              },    
            ),
          ),
        );
      },
    );
  }

  List<BuStepperChild> _buildStepperChildren(BuildContext context, List<BuildOn> buildOns, {bool isSmall}) {
    final List<BuStepperChild> result = [];

    final String currentBuildOn = builder.associatedProjects.first.currentBuildOn ?? buildOns.first.id;

    for (final buildOn in buildOns) {
      bool hasNotification = builder.associatedProjects.first.hasNotification;

      if (buildOn.id != currentBuildOn) {
        hasNotification = false;
      }

      result.add(
        BuStepperChild(
          widget: Stack(
            children: [
              BuildOnCard(
                buildOn: buildOn, 
                onOpened: () async => _openBuildOn(context, buildOn, buildOns), 
                isSmall: isSmall,
              ),
              if (hasNotification)
                const Positioned(
                  top: 25,
                  right: 10,
                  child: BuNotificationDot(),
                ),
              
            ],
          ),
          color: buildOn.id != currentBuildOn ? const Color(0xff17ba63) : const Color(0xffaeb5b7)
        )
      );

      if (buildOn.id == currentBuildOn) {
        break;
      }
    }

    return result;
  }

  Future _openBuildOn(BuildContext context, BuildOn buildOn, List<BuildOn> buildOns) async {
    await Navigator.push<void>(
      context,
      CupertinoPageRoute(
        builder: (context) => BuilderBuildOnStepsPage(
          builder: builder, 
          buildOn: buildOn,
          nextBuildOn: buildOns.last == buildOn ? null : buildOns[buildOns.indexOf(buildOn) + 1]
        )
      )
    );
  }
}