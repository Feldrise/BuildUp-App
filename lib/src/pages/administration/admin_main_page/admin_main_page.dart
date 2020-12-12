import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/administration/admin_active_pages/admin_active_page.dart';
import 'package:buildup/src/pages/administration/admin_buildons_page/admin_buildons_page.dart';
import 'package:buildup/src/pages/administration/admin_candidating_pages/admin_candidating_page.dart';
import 'package:buildup/src/pages/administration/admin_ntf_referents_page/admin_ntf_referents_page.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:buildup/src/providers/active_builers_store.dart';
import 'package:buildup/src/providers/active_coachs_store.dart';
import 'package:buildup/src/providers/candidating_builders_store.dart';
import 'package:buildup/src/providers/candidating_coachs_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminMainPage extends StatelessWidget {
  final List<Widget> pages = [
    AdminCandidatingPage(),
    Navigator(
      key: GlobalKey<NavigatorState>(),
      onGenerateRoute: (route) => MaterialPageRoute<void>(
        settings: route,
        builder: (context) => AdminActivePage()
      ),
    ),
    Navigator(
      key: GlobalKey<NavigatorState>(),
      onGenerateRoute: (route) => MaterialPageRoute<void>(
        settings: route,
        builder: (context) => AdminBuildOnsPage()
      ),
    ),
    AdminNtfReferentsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CandidatingBuilderStore(),),
        ChangeNotifierProvider(create: (context) => CandidatingCoachsStore()),
        ChangeNotifierProvider(create: (context) => ActiveCoachsStore()),
        ChangeNotifierProvider(create: (context) => ActiveBuildersStore()),
      ],
      builder: (context, child) {        
        final CandidatingBuilderStore candidatingBuilderStore = Provider.of<CandidatingBuilderStore>(context);
        final CandidatingCoachsStore candidatingCoachsStore = Provider.of<CandidatingCoachsStore>(context);

        int candidatingNumber = 0;
        if (candidatingBuilderStore.builders != null && candidatingCoachsStore.coachs != null) {
          candidatingNumber = candidatingBuilderStore.builders.length + candidatingCoachsStore.coachs.length;
        }

        final ActiveCoachsStore activeCoachsStore = Provider.of<ActiveCoachsStore>(context);
        final ActiveBuildersStore activeBuildersStore = Provider.of<ActiveBuildersStore>(context);

        int activeNumber = 0;
        if (activeBuildersStore.builders != null && activeCoachsStore.coachs != null) {
          activeNumber = activeBuildersStore.builders.length + activeCoachsStore.coachs.length;
        }
        
        final List<PageItem> pageItems = [
          PageItem(
            index: 0, 
            title: "Candidatures", 
            icon: Icons.book,
            suffixWidget: candidatingNumber > 0 ? Text("$candidatingNumber") : null
          ),
          PageItem(
            index: 1, 
            title: "Membres Actifs", 
            icon: Icons.person,
            suffixWidget: activeNumber > 0 ? Text("$activeNumber") : null
          ),
          PageItem(
            index: 2,
            title: "Gestion des Build-On",
            icon: Icons.build
          ),
          PageItem(
            index: 3,
            title: "Gestion des référents",
            icon: Icons.supervisor_account
          )
        ];

        return MainPage(
          pageItems: pageItems, 
          pages: pages
        );
      },
    );
  }
}