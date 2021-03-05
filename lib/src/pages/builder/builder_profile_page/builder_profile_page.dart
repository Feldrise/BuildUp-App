
import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/builder/builder_info_card.dart';
import 'package:buildup/src/shared/widgets/builder/builder_profile_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/utils/app_manager.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuilderProfilPage extends StatelessWidget {
  const BuilderProfilPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BuilderStore>(
      builder: (context, builderStore, child) {
        final horizontalPadding = ScreenUtils.instance.horizontalPadding;

        return Scaffold(
          backgroundColor: colorScaffoldGrey,
          appBar: const BuAppBar(
            title: Text("Profil"),
          ),
          body: Navigator(
            key: AppManager.instance.builderProfilKey,
            onGenerateRoute: (route) => MaterialPageRoute<void>(
              settings: route,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
                    child: Column(
                      children: [
                        BuilderProfileCard(
                          builder: builderStore.builder,
                          onSaveProfile: (builder) => _saveBuilderProfile(context, builder),
                        ),
                        const SizedBox(height: 30),
                        BuilderInfoCard(builder: builderStore.builder)
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

  Future _saveBuilderProfile(BuildContext context, BuBuilder builder) async {
    final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

    try {
      await Provider.of<BuilderStore>(context, listen: false).updateBuilder(authorization, builder, updateUser: true);
    }
    on Exception {
      rethrow;
    }
  }


}