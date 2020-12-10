import 'package:buildup/entities/builder.dart';
import 'package:buildup/entities/buildons/buildon.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_builders_page/admin_buildon_step_active_builder_page/admin_buildon_step_active_builder_page.dart';
import 'package:buildup/src/providers/buildons_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/bu_appbar.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/bu_stepper.dart';
import 'package:buildup/src/shared/widgets/buildons/buildon_card.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBuildOnsActiveBuilderPage extends StatelessWidget {
  const AdminBuildOnsActiveBuilderPage({Key key, @required this.builder}) : super(key: key);
  
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
                            constraints: const BoxConstraints(maxWidth: 800),
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
      result.add(
        BuStepperChild(
          widget: BuildOnCard(
            buildOn: buildOn, 
            onOpened: () async => _openBuildOn(context, buildOn), 
            isSmall: isSmall,
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

  Future _openBuildOn(BuildContext context, BuildOn buildOn) async {
    await Navigator.push<void>(
      context,
      CupertinoPageRoute(
        builder: (context) => AdminBuildOnStepActiveBuilderPage(builder: builder, buildOn: buildOn,)
      )
    );
  }
}