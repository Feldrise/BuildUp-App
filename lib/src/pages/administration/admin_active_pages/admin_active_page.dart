
import 'package:buildup/entities/tab_item.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:buildup/services/coachs_services.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_builders_page/admin_active_builders_page.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_coachs_page/admin_active_coachs_page.dart';
import 'package:buildup/src/providers/active_builers_store.dart';
import 'package:buildup/src/providers/active_coachs_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/bu_tab_widget/bu_tab_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:buildup/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminActivePage extends StatefulWidget {
  @override
  _AdminActivePageState createState() => _AdminActivePageState();
}

class _AdminActivePageState extends State<AdminActivePage> {
  final List<TabItem> tabItems = [
    TabItem(
      index: 0, 
      title: "Builders"
    ),
    TabItem(
      index: 1, 
      title: "Coach"
    )
  ];

  final List<Widget> pages = const [
    AdminActiveBuildersPage(),
    AdminActiveCoachsPage(),
  ];
  
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ScreenUtils.instance.horizontalPadding;

    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      body: FutureBuilder<void>(
        future: _loadData(),
        builder: (context, snaphsot) {
          if (snaphsot.connectionState == ConnectionState.done) {
            if (snaphsot.hasError) {
              return Center(
                child: BuStatusMessage(
                  title: "Erreur lors de la récupération des membres actifs",
                  message: snaphsot.error.toString(),
                ),
              );
            }
            return BuTabWidget(
              tabItems: tabItems,
              pages: pages,
            );
          }

          return Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    width: 84,
                    height: 84,
                    child: CircularProgressIndicator()
                  ),
                  SizedBox(height: 30,),
                  Text("Récupération des données des membres actifs")
                ]
              ),
            ),
          );
        },
      )
    );
  }

  Future _loadData() async {
    final ActiveBuildersStore activeBuildersStore = Provider.of<ActiveBuildersStore>(context, listen: false);
    final ActiveCoachsStore activeCoachsStore = Provider.of<ActiveCoachsStore>(context, listen: false);

    if (activeBuildersStore.hasData && activeCoachsStore.hasData) {
      return;
    }

    final UserStore currentUser = Provider.of<UserStore>(context, listen: false);

    activeBuildersStore.builders = await BuildersService.instance.getActiveBuilders(currentUser.authentificationHeader);
    activeCoachsStore.coachs = await CoachsService.instance.getActiveCoachs(currentUser.authentificationHeader);
  }
}