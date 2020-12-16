
import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/coach/coach_profile_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoachProfilPage extends StatelessWidget {
  const CoachProfilPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CoachStore>(
      builder: (context, coachStore, child) {
        return Scaffold(
          backgroundColor: colorScaffoldGrey,
          appBar: const BuAppBar(
            title: Text("Profil"),
          ),
          body: Navigator(
            key: GlobalKey<NavigatorState>(),
            onGenerateRoute: (route) => MaterialPageRoute<void>(
              settings: route,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        CoachProfileCard(
                          coach: coachStore.coach,
                          onSaveProfile: (coach) => _saveCoachProfile(context, coach),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          )
        );
      },
    );
  }

  Future _saveCoachProfile(BuildContext context, Coach coach) async {
    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

    try {
      await Provider.of<CoachStore>(context, listen: false).updateCoach(authorization, coach, updateUser: true);
    }
    on Exception {
      rethrow;
    }
  }


}