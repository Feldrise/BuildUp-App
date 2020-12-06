import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/administration/admin_main_page/admin_candidating_pages/admin_candidating_page.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:buildup/src/providers/candidating_builders_store.dart';
import 'package:buildup/src/providers/candidating_coachs_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminMainPage extends StatelessWidget {
  final List<Widget> pages = [
    AdminCandidatingPage(),
    const Center(child: Text("Hello Membres Actifs",)),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CandidatingBuilderStore(),),
        ChangeNotifierProvider(create: (context) => CandidatingCoachsStore()),
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
        ];

        return MainPage(
          pageItems: pageItems, 
          pages: pages
        );
      },
    );
  }
}