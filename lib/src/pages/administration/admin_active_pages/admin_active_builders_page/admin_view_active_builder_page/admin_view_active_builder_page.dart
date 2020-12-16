
import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/shared/widgets/general/admin_active_member_form_card.dart';
import 'package:buildup/src/providers/active_builers_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/builder/builder_info_card.dart';
import 'package:buildup/src/shared/widgets/builder/builder_profile_card.dart';
import 'package:buildup/src/shared/widgets/builder/builder_project_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    BuilderProfileCard(builder: builder, onSaveProfile: (builder) => _saveBuilderProfile(context, builder)),
                    const SizedBox(height: 30),
                    BuilderInfoCard(builder: builder, onSaveInfo: (builder) => _saveBuilderInfo(context, builder),),
                    const SizedBox(height: 30),
                    BuilderProjectCard(builder: builder, onSaveProject: (builder) => _saveBuilderProject(context, builder),),
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
  
  Future _saveBuilderProfile(BuildContext context, BuBuilder builder) async {
    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

    try {
      await Provider.of<ActiveBuildersStore>(context, listen: false).updateBuilder(authorization, builder, updateUser: true);
    }
    on Exception {
      rethrow;
    }
  }

  Future _saveBuilderInfo(BuildContext context, BuBuilder builder) async {
    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

    try {
      await Provider.of<ActiveBuildersStore>(context, listen: false).updateBuilder(authorization, builder);
    }
    on Exception {
      rethrow;
    }

  }

  Future _saveBuilderProject(BuildContext context, BuBuilder builder) async {
    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

    try {
      await Provider.of<ActiveBuildersStore>(context, listen: false).updateBuilder(authorization, builder, updateProject: true);

    }
    on Exception {
      rethrow;
    }

  }

}