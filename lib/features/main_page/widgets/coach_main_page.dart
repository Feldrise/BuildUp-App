import 'package:buildup/core/utils/app_manager.dart';
import 'package:buildup/features/builders/widgets/coach_builders_page.dart';
import 'package:buildup/features/main_page/main_page.dart';
import 'package:buildup/features/main_page/page_item.dart';
import 'package:flutter/material.dart';

class CoachMainPage extends StatelessWidget {
  const CoachMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The pages
    final List<Widget> pages = [
      ClipRect(
        child: Navigator(
          key: AppManager.instance.coachBuildersKey,
          onGenerateRoute: (route) => MaterialPageRoute<void>(
            settings: route,
            builder: (context) => const CoachBuildersPage()
          ),
        )
      ),
    ];

    // The menu items
    const List<PageItem> pageItems = [
      // Build Ons
      PageItem(
        index: 0, 
        title: "Mes Builders",
        icon: Icons.supervisor_account
      ),
    ];

    return MainPage(
      pageItems: pageItems, 
      pages: pages
    );
  }
}