import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/administration/admin_buildons_page/admin_buildons_page.dart';
import 'package:buildup/src/pages/administration/admin_candidating_pages/admin_candidating_page.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:buildup/src/providers/buildons_store.dart';
import 'package:buildup/src/providers/candidating_builders_store.dart';
import 'package:buildup/src/providers/candidating_coachs_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminMainPage extends StatelessWidget {
  final List<Widget> pages = [
    AdminCandidatingPage(),
    const Center(child: Text("Hello Membres Actifs",)),
    Navigator(
      onGenerateRoute: (route) => MaterialPageRoute<void>(
        settings: route,
        builder: (context) => AdminBuildOnsPage()
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CandidatingBuilderStore(),),
        ChangeNotifierProvider(create: (context) => CandidatingCoachsStore()),
        ChangeNotifierProvider(create: (context) => BuildOnsStore(),),
      ],
      builder: (context, child) {        
        final CandidatingBuilderStore candidatingBuilderStore = Provider.of<CandidatingBuilderStore>(context);
        final CandidatingCoachsStore candidatingCoachsStore = Provider.of<CandidatingCoachsStore>(context);

        int candidatingNumber = 0;
        if (candidatingBuilderStore.builders != null && candidatingCoachsStore.coachs != null) {
          candidatingNumber = candidatingBuilderStore.builders.length + candidatingCoachsStore.coachs.length;
        }
        
        final List<PageItem> pageItems = [
          PageItem(
            index: 0, 
            title: "Candidatures", 
            icon: Icons.book,
            suffixWidget: Text("$candidatingNumber")
          ),
          PageItem(
            index: 1, 
            title: "Membres Actifs", 
            icon: Icons.person,
          ),
          PageItem(
            index: 2,
            title: "Gestion des Build-On",
            icon: Icons.build
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