
import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_builders_page/admin_view_active_builder_page/widgets/admin_active_builder_info_card.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_builders_page/admin_view_active_builder_page/widgets/admin_active_builder_profile_card.dart';
import 'package:buildup/src/shared/widgets/bu_appbar.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminViewActiveBuilderPage extends StatelessWidget {
  const AdminViewActiveBuilderPage({
    Key key,
    @required this.builder
  }) : super(key: key);

  final BuBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      appBar: BuAppBar(
        title: Text("Builder : ${builder.associatedUser.fullName}", style: Theme.of(context).textTheme.headline5,),
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
                    AdminActiveBuilderProfileCard(builder: builder),
                    const SizedBox(height: 30),
                    AdminActiveBuilderInfoCard(builder: builder),
                    // const SizedBox(height: 30),
                    // AdminActiveCoachFormCard(coach: coach)
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