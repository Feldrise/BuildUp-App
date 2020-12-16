
import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/pages/coachs/coach_builders_page/widgets/coach_builder_card.dart';
import 'package:buildup/src/providers/coach_builders_store.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoachBuildersPage extends StatelessWidget {
  const CoachBuildersPage({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      body: Consumer3<UserStore, CoachStore, CoachBuildersStore>(
        builder: (context, userStore, coachStore, coachBuildersStore, child) {
          return RefreshIndicator(
            onRefresh: () async => coachBuildersStore.clear(),
            child: Stack(
              children: [
                ListView(), // Here to make the RefreshIndicator working
                FutureBuilder(
                  future: coachBuildersStore.builders(userStore.authentificationHeader, coachStore.coach),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: BuStatusMessage(
                            title: "Erreur lors de la récupération de vos builders",
                            message: snapshot.error.toString(),
                          ),
                        );
                      }

                      final List<BuBuilder> coachBuilders = snapshot.data as List<BuBuilder>;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!coachBuildersStore.hasData) ...{
                            const Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: BuStatusMessage(
                                  type: BuStatusMessageType.info,
                                  message: "Vous n'avez aucun Builder pour le moment",
                                ),
                              ),
                            )
                          }
                          else 
                            Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return SingleChildScrollView(
                                  child: Wrap(
                                    children: [
                                      for (final builder in coachBuilders) 
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                          child: CoachBuilderCard(
                                            builder: builder,
                                            width: constraints.maxWidth > 500 ? 250 : constraints.maxWidth,
                                          ),
                                        )
                                    ],
                                  ),
                                );
                              },
                            )
                          )
                        ]
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
                            Text("Récupération des données des builders...")
                          ]
                        ),
                      ),
                    );
                  },
                ),
              ]
            )
          );
        },
      ),
    );
  }
}