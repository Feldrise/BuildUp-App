
import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/providers/coach_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/coach/coach_info_card.dart';
import 'package:buildup/src/shared/widgets/coach/coach_profile_card.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoachProfilPage extends StatelessWidget {
  const CoachProfilPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ScreenUtils.instance.horizontalPadding;

    return Consumer<CoachStore>(
      builder: (context, coachStore, child) {
        return Scaffold(
          backgroundColor: colorScaffoldGrey,
          body: Navigator(
            key: GlobalKey<NavigatorState>(),
            onGenerateRoute: (route) => MaterialPageRoute<void>(
              settings: route,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
                    child: Column(
                      children: [
                        CoachProfileCard(
                          coach: coachStore.coach,
                          onSaveProfile: (coach) => _saveCoachProfile(context, coach),
                        ),
                        const SizedBox(height: 30),
                        CoachInfoCard(coach: coachStore.coach),
                    
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