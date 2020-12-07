
import 'package:buildup/entities/tab_item.dart';
import 'package:buildup/services/coachs_services.dart';
import 'package:buildup/src/providers/active_coachs_store.dart';
import 'package:buildup/src/providers/user_store.dart';
import 'package:buildup/src/shared/widgets/bu_status_message.dart';
import 'package:buildup/src/shared/widgets/bu_tab_widget/bu_tab_widget.dart';
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
    Center(child: Text("Hello Active builders"),),
    Center(child: Text("Hello Active coachs"),)
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      )
    );
  }

  Future _loadData() async {
    // final CandidatingBuilderStore candidatingBuilderStore = Provider.of<CandidatingBuilderStore>(context, listen: false);
    final ActiveCoachsStore activeCoachsStore = Provider.of<ActiveCoachsStore>(context, listen: false);

    if (/*candidatingBuilderStore.hasData &&*/ activeCoachsStore.hasData) {
      return;
    }

    final UserStore currentUser = Provider.of<UserStore>(context, listen: false);

    // candidatingBuilderStore.builders = await BuildersService.instance.getCandidatingBuilders(currentUser.authentificationHeader);
    activeCoachsStore.coachs = await CoachsService.instance.getActiveCoachs(currentUser.authentificationHeader);
  }
}