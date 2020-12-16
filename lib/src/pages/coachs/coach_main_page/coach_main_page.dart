
import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/coachs/coach_builders_page/caoch_builders_page.dart';
import 'package:buildup/src/pages/coachs/coach_profile_page/coach_profile_page.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:buildup/src/providers/coach_builders_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoachMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CoachBuildersStore(),)
      ],
      builder: (context, child) {
        final List<Widget> pages = [
          const CoachProfilPage(),
          Navigator(
            key: GlobalKey<NavigatorState>(),
            onGenerateRoute: (route) => MaterialPageRoute<void>(
              settings: route,
              builder: (context) => const CoachBuildersPage()
            ),
          ),
        ];

        final CoachBuildersStore coachBuildersStore = Provider.of<CoachBuildersStore>(context);

        int buildersCount = 0;
        if (coachBuildersStore.loadedBuilders != null) {
            buildersCount = coachBuildersStore.loadedBuilders.length;
        }
          
        final List<PageItem> pageItems = [
          PageItem(
            index: 0, 
            title: "Profil", 
            icon: Icons.account_circle,
          ),
          PageItem(
            index: 1, 
            title: "Mes Builders", 
            icon: Icons.supervisor_account,
            suffixWidget: buildersCount > 0 ? Text("$buildersCount") : null
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