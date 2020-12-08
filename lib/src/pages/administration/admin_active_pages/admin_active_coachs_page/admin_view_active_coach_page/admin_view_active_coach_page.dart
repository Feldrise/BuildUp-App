import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/widgets/admin_active_member_form_card.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_coachs_page/admin_view_active_coach_page/widgets/admin_active_coach_info_card.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_coachs_page/admin_view_active_coach_page/widgets/admin_active_coach_profile_card.dart';
import 'package:buildup/src/shared/widgets/bu_appbar.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminViewActiveCoachPage extends StatelessWidget {
  const AdminViewActiveCoachPage({
    Key key,
    @required this.coach
  }) : super(key: key);

  final Coach coach;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      appBar: BuAppBar(
        title: Text("Coach : ${coach.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5,),
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
                    AdminActiveCoachProfileCard(coach: coach),
                    const SizedBox(height: 30),
                    AdminActiveCoachInfoCard(coach: coach),
                    const SizedBox(height: 30),
                    AdminActiveMemberFormCard(form: coach.associatedForm,)
                  ],
                ),
              ),
            );
          }
        ),
      )
    );
  }

}