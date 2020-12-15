import 'package:buildup/entities/tab_item.dart';
import 'package:buildup/services/builders_service.dart';
import 'package:buildup/services/coachs_services.dart';
import 'package:buildup/src/pages/administration/admin_candidating_pages/admin_coachs_candidating_page/admin_coachs_candidating_page.dart';
import 'package:buildup/src/providers/candidating_builders_store.dart';
import 'package:buildup/src/providers/candidating_coachs_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/general/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/bu_tab_widget/bu_tab_widget.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_builders_candidating_page/admin_builders_candidating_page.dart';

class AdminCandidatingPage extends StatefulWidget {
  @override
  _AdminCandidatingPageState createState() => _AdminCandidatingPageState();
}

class _AdminCandidatingPageState extends State<AdminCandidatingPage> {
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
    AdminBuildersCandidatingPage(),
    AdminCoachsCandidatingPage()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldGrey,
      body: FutureBuilder<void>(
        future: _loadData(),
        builder: (context, snaphsot) {
          if (snaphsot.connectionState == ConnectionState.done) {
            if (snaphsot.hasError) {
              return Center(
                child: BuStatusMessage(
                  title: "Erreur lors de la récupération des candidats",
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
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
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
                  Text("Récupération des données des candidats")
                ]
              ),
            ),
          );
        },
      ),
    );
  }

  Future _loadData() async {
    final CandidatingBuilderStore candidatingBuilderStore = Provider.of<CandidatingBuilderStore>(context, listen: false);
    final CandidatingCoachsStore candidatingCoachsStore = Provider.of<CandidatingCoachsStore>(context, listen: false);

    if (candidatingBuilderStore.hasData && candidatingCoachsStore.hasData) {
      return;
    }

    final UserStore currentUser = Provider.of<UserStore>(context, listen: false);

    candidatingBuilderStore.builders = await BuildersService.instance.getCandidatingBuilders(currentUser.authentificationHeader);
    candidatingCoachsStore.coachs = await CoachsService.instance.getCandidatingCoach(currentUser.authentificationHeader);
  }
}