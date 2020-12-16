import 'package:buildup/entities/coach.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_coachs_page/admin_view_active_coach_page/admin_view_active_coach_page.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_coachs_page/dialogs/admin_active_coach_delete_dialog.dart';
import 'package:buildup/src/providers/active_coachs_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/dialogs/dialogs.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin AdminActiveCoachCardAction {
  static const String viewProfile = "viewProfile";
  static const String delete = "Delete";

  static const Map<String, IconData> icon = {
    viewProfile: Icons.account_circle,
    delete: Icons.delete_forever
  };

  static const Map<String, Color> color = {
    viewProfile: colorBlack,
    delete: colorPrimary
  };

  static const Map<String, String> detailled = {
    viewProfile: "Profil",
    delete: "Supprimer"
  };
}

class AdminActiveCoachCard extends StatelessWidget {
  const AdminActiveCoachCard({Key key, @required this.coach, this.width}) : super(key: key);

  final Coach coach;

  final double width;

  @override
  Widget build(BuildContext context) {
    return BuCard(
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
                )
              )
            ],
          ),
          const SizedBox(height: 30,),
          Center(
            child: SizedBox(
              width: 48,
              height: 48,
              child: BuImageWidget(
                image: coach.associatedUser.profilePicture,
                isCircular: true,
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Text(coach.associatedUser.fullName, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6,),
          Text(coach.situation.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(color: Color(0xff919c9e), fontSize: 12),),
          const SizedBox(height: 32,),
          BuButton(
            buttonType: BuButtonType.secondary,
            icon: Icons.account_circle,
            text: "Voir le profil", 
            onPressed: () => _navigate(context, AdminActiveCoachCardAction.viewProfile)
          )
        ],
      )
    );
  }

  Widget _buildCurrentStep() {
    if (coach.step == CoachSteps.meeting) {
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
        value: AdminActiveCoachCardAction.viewProfile,
        child: Row(
          children: [
            Icon(
              AdminActiveCoachCardAction.icon[AdminActiveCoachCardAction.viewProfile],
              size: 15,
              color: AdminActiveCoachCardAction.color[AdminActiveCoachCardAction.viewProfile],
            ),
            const SizedBox(width: 3,),
            Text(
              AdminActiveCoachCardAction.detailled[AdminActiveCoachCardAction.viewProfile],
              style: TextStyle(fontSize: 12, color: AdminActiveCoachCardAction.color[AdminActiveCoachCardAction.viewProfile]),
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: AdminActiveCoachCardAction.delete,
        child: Row(
          children: [
            Icon(
              AdminActiveCoachCardAction.icon[AdminActiveCoachCardAction.delete],
              size: 15,
              color: AdminActiveCoachCardAction.color[AdminActiveCoachCardAction.delete],
            ),
            const SizedBox(width: 3,),
            Text(
              AdminActiveCoachCardAction.detailled[AdminActiveCoachCardAction.delete],
              style: TextStyle(fontSize: 12, color: AdminActiveCoachCardAction.color[AdminActiveCoachCardAction.delete]),
            )
          ],
        ),
      )
    ];
  }

  Future _navigate(BuildContext context, String route) async {
    if (route == AdminActiveCoachCardAction.delete) {
      final bool delete = await showDialog<bool>(
        context: context,
        builder: (context) => AdminActiveCoachDeleteDialog(coach: coach)
      );

      if (delete != null && delete) {
        final GlobalKey<State> keyLoader = GlobalKey<State>();
        Dialogs.showLoadingDialog(context, keyLoader, "Suppression en cours"); 

        try {
          final String authorization = Provider.of<UserStore>(context, listen: false).authentificationHeader;

          await Provider.of<ActiveCoachsStore>(context, listen: false).refuseCoach(authorization, coach);
        } on Exception {
          Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
          return;
        }

        Navigator.of(keyLoader.currentContext,rootNavigator: true).pop(); 
        return;
      }
    }

    Widget page;

    if (route == AdminActiveCoachCardAction.viewProfile) {
      page = AdminViewActiveCoachPage(coach: coach);
    }

    if (page != null) {
      await Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (context) => page
        )
        // PageRouteBuilder(
        //   pageBuilder: (context, animation, anotherAnimation) => page,
        //   transitionsBuilder: (context, animation, anotherAnimation, child) {
        //     animation = CurvedAnimation(parent: animation, curve: Curves.linear);

        //     return FadeTransition(
        //       opacity: animation,
        //       child: child,
        //     );
        //   }
        // )
      );
    }

  }
}