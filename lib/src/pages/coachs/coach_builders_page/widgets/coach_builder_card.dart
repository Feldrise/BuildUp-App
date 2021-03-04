
import 'package:buildup/entities/builder.dart';
import 'package:buildup/src/pages/builder_buildons_page/builder_buildon_page.dart';
import 'package:buildup/src/pages/coachs/coach_builders_page/coach_view_builder_page/coach_view_builder_page.dart';
import 'package:buildup/src/pages/meeting_reports_page/meeting_reports_page.dart';
import 'package:buildup/src/shared/widgets/general/bu_button.dart';
import 'package:buildup/src/shared/widgets/general/bu_card.dart';
import 'package:buildup/src/shared/widgets/general/bu_image_widget.dart';
import 'package:buildup/src/shared/widgets/general/bu_notification_dot.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin CoachBuilderCardAction {
  static const String viewProfile = "viewProfile";
  static const String viewRepports = "viewRepports";
  static const String viewBuildOns = "viewBuildOns";

  static const Map<String, IconData> icon = {
    viewProfile: Icons.account_circle,
    viewRepports: Icons.assignment,
    viewBuildOns: Icons.view_day,
  };

  static const Map<String, Color> color = {
    viewProfile: colorBlack,
    viewRepports: colorBlack,
    viewBuildOns: colorBlack,
  };

  static const Map<String, String> detailled = {
    viewProfile: "Profil",
    viewRepports: "Rapports",
    viewBuildOns: "Builds On",
  };
}

class CoachBuilderCard extends StatelessWidget {
  const CoachBuilderCard({Key key, @required this.builder, this.width}) : super(key: key);

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
                onPressed: () => _navigate(context, CoachBuilderCardAction.viewProfile)
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
        value: CoachBuilderCardAction.viewProfile,
        child: Row(
          children: [
            Icon(
              CoachBuilderCardAction.icon[CoachBuilderCardAction.viewProfile],
              size: 15,
              color: CoachBuilderCardAction.color[CoachBuilderCardAction.viewProfile],
            ),
            const SizedBox(width: 3,),
            Text(
              CoachBuilderCardAction.detailled[CoachBuilderCardAction.viewProfile],
              style: TextStyle(fontSize: 12, color: CoachBuilderCardAction.color[CoachBuilderCardAction.viewProfile]),
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: CoachBuilderCardAction.viewRepports,
        child: Row(
          children: [
            Icon(
              CoachBuilderCardAction.icon[CoachBuilderCardAction.viewRepports],
              size: 15,
              color: CoachBuilderCardAction.color[CoachBuilderCardAction.viewRepports],
            ),
            const SizedBox(width: 3,),
            Text(
              CoachBuilderCardAction.detailled[CoachBuilderCardAction.viewRepports],
              style: TextStyle(fontSize: 12, color: CoachBuilderCardAction.color[CoachBuilderCardAction.viewRepports]),
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: CoachBuilderCardAction.viewBuildOns,
        child: Row(
          children: [
            Icon(
              CoachBuilderCardAction.icon[CoachBuilderCardAction.viewBuildOns],
              size: 15,
              color: CoachBuilderCardAction.color[CoachBuilderCardAction.viewBuildOns],
            ),
            const SizedBox(width: 3,),
            Text(
              CoachBuilderCardAction.detailled[CoachBuilderCardAction.viewBuildOns],
              style: TextStyle(fontSize: 12, color: CoachBuilderCardAction.color[CoachBuilderCardAction.viewBuildOns]),
            )
          ],
        ),
      ),
    ];
  }

  Future _navigate(BuildContext context, String route) async {
    Widget page;

    if (route == CoachBuilderCardAction.viewProfile) {
      page = CoachViewBuilderPage(builder: builder);
    }
    else if (route == CoachBuilderCardAction.viewBuildOns) {
      page = BuilderBuildOnsPage(builder: builder);
    }
    else if (route == CoachBuilderCardAction.viewRepports) {
      page = MeetingRepportsPage(builder: builder);
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