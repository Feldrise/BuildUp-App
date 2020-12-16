
import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_builders_page/admin_view_active_builder_page/admin_view_active_builder_page.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_builders_page/dialogs/admin_active_builder_delete_dialog.dart';
import 'package:buildup/src/pages/builder_buildons_page/builder_buildon_page.dart';
import 'package:buildup/src/providers/active_builers_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:buildup/src/shared/widgets/general/bu_notification_dot.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

mixin AdminActiveBuilderCardAction {
  static const String viewProfile = "viewProfile";
  static const String viewRepports = "viewRepports";
  static const String viewBuildOns = "viewBuildOns";
  static const String delete = "Delete";

  static const Map<String, IconData> icon = {
    viewProfile: Icons.account_circle,
    viewRepports: Icons.assignment,
    viewBuildOns: Icons.view_day,
    delete: Icons.delete_forever
  };

  static const Map<String, Color> color = {
    viewProfile: colorBlack,
    viewRepports: colorBlack,
    viewBuildOns: colorBlack,
    delete: colorPrimary
  };

  static const Map<String, String> detailled = {
    viewProfile: "Profil",
    viewRepports: "Rapports",
    viewBuildOns: "Build-Ons",
    delete: "Supprimer"
  };
}

class AdminActiveBuilderCard extends StatelessWidget {
  const AdminActiveBuilderCard({Key key, @required this.builder, this.width}) : super(key: key);

  final BuBuilder builder;

  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BuCard(
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 85,
                    child: _buildCurrentStep()
                  ),
                  Expanded(
                    flex: 15,
                    child: PopupMenuButton<String>(
                      onSelected: (route) async {
                        await _navigate(context, route);
                      },
                      itemBuilder: _populateMenu,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              Center(
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: BuImageWidget(
                    image: builder.associatedUser.profilePicture,
                    isCircular: true,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Text(builder.associatedUser.fullName, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6,),
              Text(builder.associatedProjects.first.name.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(color: Color(0xff919c9e), fontSize: 12),),
              const SizedBox(height: 20,),
              Text("Date de fin : ${DateFormat('dd/MM/yyyy').format(builder.programEndDate)}", textAlign: TextAlign.center,),
              const SizedBox(height: 32,),
              BuButton(
                buttonType: BuButtonType.secondary,
                icon: Icons.account_circle,
                text: "Voir le profil", 
                onPressed: () => _navigate(context, AdminActiveBuilderCardAction.viewProfile)
              )
            ],
          )
        ),
        if (builder.associatedProjects.first.hasNotification)
          const Positioned(
            top: 10,
            right: 10,
            child: BuNotificationDot(),
          ),
      ],
    );
  }

  
  Widget _buildCurrentStep() {
    if (builder.step == BuilderSteps.adminMeeting) {
      return Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: const Color(0xfff4bd2a),
              borderRadius: BorderRadius.circular(15)
            ),
            child: const Center(child: Icon(Icons.watch_later, size: 15, color: Colors.white,),),
          ),
          const SizedBox(width: 5,),
          const Flexible(child: Text("Entretien avec un admin", style: TextStyle(color: Color(0xfff4bd2a)),))
        ],
      );
    }

    if (builder.step == BuilderSteps.coachMeeting) {
      Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: const Color(0xfff4bd2a),
              borderRadius: BorderRadius.circular(15)
            ),
            child: const Center(child: Icon(Icons.watch_later, size: 15, color: Colors.white,),),
          ),
          const SizedBox(width: 5,),
          const Flexible(child: Text("Choix du coach", style: TextStyle(color: Color(0xfff4bd2a)),))
        ],
      );
    }

    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: const Color(0xff17ba63),
            borderRadius: BorderRadius.circular(15)
          ),
          child: const Center(child: Icon(Icons.check, size: 15, color: Colors.white,),),
        ),
        const SizedBox(width: 5,),
        const Flexible(child: Text("Actif", style: TextStyle(color: Color(0xff17ba63)),))
      ],
    );
  }

  List<PopupMenuEntry<String>> _populateMenu(BuildContext context) {
    return [
      PopupMenuItem(
        value: AdminActiveBuilderCardAction.viewProfile,
        child: Row(
          children: [
            Icon(
              AdminActiveBuilderCardAction.icon[AdminActiveBuilderCardAction.viewProfile],
              size: 15,
              color: AdminActiveBuilderCardAction.color[AdminActiveBuilderCardAction.viewProfile],
            ),
            const SizedBox(width: 3,),
            Text(
              AdminActiveBuilderCardAction.detailled[AdminActiveBuilderCardAction.viewProfile],
              style: TextStyle(fontSize: 12, color: AdminActiveBuilderCardAction.color[AdminActiveBuilderCardAction.viewProfile]),
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: AdminActiveBuilderCardAction.viewRepports,
        child: Row(
          children: [
            Icon(
              AdminActiveBuilderCardAction.icon[AdminActiveBuilderCardAction.viewRepports],
              size: 15,
              color: AdminActiveBuilderCardAction.color[AdminActiveBuilderCardAction.viewRepports],
            ),
            const SizedBox(width: 3,),
            Text(
              AdminActiveBuilderCardAction.detailled[AdminActiveBuilderCardAction.viewRepports],
              style: TextStyle(fontSize: 12, color: AdminActiveBuilderCardAction.color[AdminActiveBuilderCardAction.viewRepports]),
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: AdminActiveBuilderCardAction.viewBuildOns,
        child: Row(
          children: [
            Icon(
              AdminActiveBuilderCardAction.icon[AdminActiveBuilderCardAction.viewBuildOns],
              size: 15,
              color: AdminActiveBuilderCardAction.color[AdminActiveBuilderCardAction.viewBuildOns],
            ),
            const SizedBox(width: 3,),
            Text(
              AdminActiveBuilderCardAction.detailled[AdminActiveBuilderCardAction.viewBuildOns],
              style: TextStyle(fontSize: 12, color: AdminActiveBuilderCardAction.color[AdminActiveBuilderCardAction.viewBuildOns]),
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: AdminActiveBuilderCardAction.delete,
        child: Row(
          children: [
            Icon(
              AdminActiveBuilderCardAction.icon[AdminActiveBuilderCardAction.delete],
              size: 15,
              color: AdminActiveBuilderCardAction.color[AdminActiveBuilderCardAction.delete],
            ),
            const SizedBox(width: 3,),
            Text(
              AdminActiveBuilderCardAction.detailled[AdminActiveBuilderCardAction.delete],
              style: TextStyle(fontSize: 12, color: AdminActiveBuilderCardAction.color[AdminActiveBuilderCardAction.delete]),
            )
          ],
        ),
      )
    ];
  }

  Future _navigate(BuildContext context, String route) async {
    if (route == AdminActiveBuilderCardAction.delete) {
      final bool delete = await showDialog<bool>(
        context: context,
        builder: (context) => AdminActiveBuilderDeleteDialog(builder: builder)
      );

      if (delete != null && delete) {
        final GlobalKey<State> keyLoader = GlobalKey<State>();
        Dialogs.showLoadingDialog(context, keyLoader, "Suppression en cours"); 

        try {
          final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

          await Provider.of<ActiveBuildersStore>(context, listen: false).refuseBuilder(authorization, builder);
        } on Exception {
          Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
          return;
        }

        Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
        return;
      }
    }

    Widget page;

    if (route == AdminActiveBuilderCardAction.viewProfile) {
      page = AdminViewActiveBuilderPage(builder: builder);
    }
    else if (route == AdminActiveBuilderCardAction.viewBuildOns) {
      page = BuilderBuildOnsPage(builder: builder);
    }

    if (page != null) {
      await Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (context) => page
        )
      );
    }

  }
}