import 'package:buildup/entities/notification/coach_request.dart';
import 'package:buildup/entities/user.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoachRequestCard extends StatelessWidget {
  const CoachRequestCard({
    Key key, 
    @required this.request,
    @required this.onAccepted, 
    @required this.onRefused
  }) : super(key: key);

  final CoachRequest request;

  final Function() onAccepted;
  final Function() onRefused;

  @override
  Widget build(BuildContext context) {
    return Consumer<CoachStore>(
      builder: (context, coachStore, child) {
        return BuCard(
          child: FutureBuilder(
            future: BuildersService.instance.getUserForBuilder(coachStore.coach.associatedUser.authentificationHeader, request.builderId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Impossible de récupérer les information du builder..."));
                }

                final User builderUser = snapshot.data as User;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("${builderUser.fullName} souhaite vous avoir en temps que Coach"),
                    const SizedBox(height: 8.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          onPressed: onRefused,
                          child: const Text("REFUSER", style: TextStyle(color: colorTextError)),
                        ),
                        FlatButton(
                          onPressed: onAccepted,
                          child: const Text("ACCEPTER", style: TextStyle(color: colorTextSuccess,)),
                        )
                      ],
                    )
                  ],
                );
              }

              return const Center(
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator()
                ),
              );
            },
          )
        );
      },
    );
  }
}