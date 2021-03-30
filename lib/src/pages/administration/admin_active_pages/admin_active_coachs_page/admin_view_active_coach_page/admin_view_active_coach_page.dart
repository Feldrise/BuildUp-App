import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/providers/active_coachs_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/coach/coach_info_card.dart';
import 'package:buildup/src/shared/widgets/coach/coach_profile_card.dart';
import 'package:buildup/src/shared/widgets/general/admin_active_member_form_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/utils/app_manager.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminViewActiveCoachPage extends StatelessWidget {
  const AdminViewActiveCoachPage({
    Key? key,
    required this.coach
  }) : super(key: key);

  final Coach coach;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ScreenUtils.instance.horizontalPadding;

    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      appBar: BuAppBar(
        title: Text("Coach : ${coach.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5,),
      ),
      body: Navigator(
        key: AppManager.instance.adminActiveCoachKey,
        onGenerateRoute: (route) => MaterialPageRoute<void>(
          settings: route,
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
                child: Column(
                  children: [
                    CoachProfileCard(coach: coach, onSaveProfile: (coach) => _saveCoachProfile(context, coach),),
                    const SizedBox(height: 30),
                    CoachInfoCard(coach: coach, onSaveInfo: (coach) => _saveCoachInfo(context, coach),),
                    const SizedBox(height: 30),
                    if (coach.associatedForm != null)
                      MemberFormCard(form: coach.associatedForm!,)
                  ],
                ),
              ),
            );
          }
        ),
      )
    );
  }
  
  Future _saveCoachProfile(BuildContext context, Coach coach) async {
    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

    try {
      await Provider.of<ActiveCoachsStore>(context, listen: false).updateCoach(authorization, coach, updateUser: true);
    }
    on Exception {
      rethrow;
    }
  }

  Future _saveCoachInfo(BuildContext context, Coach coach) async {
    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

    try {
      await Provider.of<ActiveCoachsStore>(context, listen: false).updateCoach(authorization, coach);
    }
    on Exception {
      rethrow;
    }
  }
}