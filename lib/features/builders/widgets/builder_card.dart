import 'package:buildup/core/widgets/bu_card.dart';
import 'package:buildup/features/buildons/buildons_page/buildons_page.dart';
import 'package:buildup/features/users/user.dart';
import 'package:buildup/features/users/user_profile_page.dart';
import 'package:buildup/features/users/widgets/step_badge.dart';
import 'package:buildup/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

enum BuilderCardRoute {
  profile, 
  report,
  buildOns,
  delete,
}

class BuilderCard extends StatelessWidget {
  const BuilderCard({
    Key? key,
    required this.builder,
    required this.refetch,
  }) : super(key: key);

  final User builder;
  final Future<QueryResult<Object?>?> Function()? refetch;

  @override
  Widget build(BuildContext context) {
    return BuCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(child: _buildHeader(context)),
          const SizedBox(height: 12,),

          ..._buildInfos(context),

          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomCenter,
            child: OutlinedButton(
              onPressed: () => _onProfileClicked(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.account_circle),
                  SizedBox(width: 8,),
                  Text("Voir le profil")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: StepBadge(step: builder.step),),
        Flexible(child: _buildMenu(context))
      ],
    );
  }

  List<Widget> _buildInfos(BuildContext context) {
    return [
      // The profile picture
      Center(
        child: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: Palette.colorLightGrey3,
            borderRadius: BorderRadius.circular(24)
          ),
        ),
      ),
      const SizedBox(height: 10,),

      // The name
      Text(
        "${builder.firstName} ${builder.lastName}", 
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),

      // The project name
      Text(
        builder.builder!.project!.name,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption,
      )
    ];
  }

  Widget _buildMenu(BuildContext context) {
    return PopupMenuButton<BuilderCardRoute>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      onSelected: (route) =>_onOpenRoute(context, route),
      itemBuilder: (context) { 
        return [
          // The view profile item
          PopupMenuItem(
            value: BuilderCardRoute.profile,
            child: _buildMenuItem(context, Icons.account_circle, "Profil"),
          ),

          // The reports item
          PopupMenuItem(
            value: BuilderCardRoute.report,
            child: _buildMenuItem(context, Icons.assignment, "Rapports"),
          ),

          // The build-ons
          PopupMenuItem(
            value: BuilderCardRoute.buildOns,
            child: _buildMenuItem(context, Icons.view_day, "Build-Ons"),
          )
        ];
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon, 
          size: 16,
          color: Theme.of(context).textTheme.caption!.color,
        ),
        const SizedBox(width: 4,),
        Text(title)
      ],
    );
  }

  Future _onProfileClicked(BuildContext context) async {
    bool shouldRefetch = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => UserProfilePage(
          userId: builder.id!,
          appBarTitle: "Builder : ${builder.firstName} ${builder.lastName}",
        ),
      )
    ) ?? false;

    if (shouldRefetch && refetch != null) {
      refetch!();
    }
  }

  Future _onOpenRoute(BuildContext context, BuilderCardRoute route) async {
    // If we open the profil
    if (route == BuilderCardRoute.profile) {
      await Navigator.of(context).push<bool?>(
        MaterialPageRoute<bool?>(
          builder: (context) => UserProfilePage(
            userId: builder.id!,
            appBarTitle: "Builder : ${builder.firstName} ${builder.lastName}",
          ),
        )
      ) ?? false;

      if (refetch != null) {
        refetch!();
      }
    }
    // If we open the build-ons
    if (route == BuilderCardRoute.buildOns) {
      await Navigator.of(context).push<dynamic>(
        MaterialPageRoute<dynamic>(
          builder: (context) => BuildOnsPage(builderId: builder.id)
        )
      );
    }
  }
}