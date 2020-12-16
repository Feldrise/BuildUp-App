
import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/shared/widgets/general/admin_active_member_form_card.dart';
import 'package:buildup/src/shared/widgets/builder/builder_info_card.dart';
import 'package:buildup/src/shared/widgets/builder/builder_profile_card.dart';
import 'package:buildup/src/shared/widgets/builder/builder_project_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class CoachViewBuilderPage extends StatelessWidget {
  const CoachViewBuilderPage({
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
                    BuilderProfileCard(builder: builder),
                    const SizedBox(height: 30),
                    BuilderInfoCard(builder: builder,),
                    const SizedBox(height: 30),
                    BuilderProjectCard(builder: builder),
                    const SizedBox(height: 30),
                    MemberFormCard(form: builder.associatedForm,)
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