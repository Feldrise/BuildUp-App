
import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/builder/builder_dashboard_page/builder_dashboard_page.dart';
import 'package:buildup/src/pages/builder/builder_profile_page/builder_profile_page.dart';
import 'package:buildup/src/pages/builder/builder_project_page/builder_project_page.dart';
import 'package:buildup/src/pages/builder_buildons_page/builder_buildon_page.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:buildup/src/pages/meeting_reports_page/meeting_reports_page.dart';
import 'package:buildup/src/providers/builder_store.dart';
import 'package:buildup/utils/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuilderMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const BuilderDashboardPage(),
      const BuilderProfilPage(),
      const BuilderProjectPage(),
      Consumer<BuilderStore>(
        builder: (context, builderStore, child) {
          return MeetingRepportsPage(builder: builderStore.builder);
        }
      ),
      Navigator(
        key: AppManager.instance.builderBuildOnsKey,
        onGenerateRoute: (route) => MaterialPageRoute<void>(
          settings: route,
          builder: (context) => BuilderBuildOnsPage(builder: Provider.of<BuilderStore>(context).builder)
        ),
      ),
      
    ];
      
    final List<PageItem> pageItems = [
      PageItem(
        index: 0,
        title: "Dashboard",
        icon: Icons.home
      ),
      PageItem(
        index: 1, 
        title: "Profil", 
        icon: Icons.account_circle,
      ),
      PageItem(
        index: 2, 
        title: "Projet", 
        icon: Icons.work,
      ),
      PageItem(
        index: 3,
        title: "Rapports",
        icon: Icons.assignment,
      ),
      PageItem(
        index: 4, 
        title: "Builds On", 
        icon: Icons.view_day,
      ),
    ];

    return MainPage(
      pageItems: pageItems, 
      pages: pages
    );
  }
}