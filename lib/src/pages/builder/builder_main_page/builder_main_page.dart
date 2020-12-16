
import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/builder/builder_profile_page/builder_profile_page.dart';
import 'package:buildup/src/pages/builder/builder_project_page/builder_project_page.dart';
import 'package:buildup/src/pages/builder_buildons_page/builder_buildon_page.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:buildup/src/providers/builder_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuilderMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const BuilderProfilPage(),
      const BuilderProjectPage(),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        onGenerateRoute: (route) => MaterialPageRoute<void>(
          settings: route,
          builder: (context) => BuilderBuildOnsPage(builder: Provider.of<BuilderStore>(context).builder)
        ),
      ),
      
    ];
      
    final List<PageItem> pageItems = [
      PageItem(
        index: 0, 
        title: "Profil", 
        icon: Icons.account_circle,
      ),
      PageItem(
        index: 1, 
        title: "Projet", 
        icon: Icons.work,
      ),
      PageItem(
        index: 2, 
        title: "Build-On", 
        icon: Icons.view_day,
      ),
    ];

    return MainPage(
      pageItems: pageItems, 
      pages: pages
    );
  }
}