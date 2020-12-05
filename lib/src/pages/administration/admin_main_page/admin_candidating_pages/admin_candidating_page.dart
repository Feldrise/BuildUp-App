import 'package:buildup/entities/tab_item.dart';
import 'package:buildup/src/pages/administration/admin_main_page/admin_candidating_pages/admin_builders_candidating_page/admin_builders_candidating_page.dart';
import 'package:buildup/src/pages/administration/admin_main_page/admin_candidating_pages/admin_coachs_candidating_page/admin_coachs_candidating_page.dart';
import 'package:buildup/src/shared/widgets/bu_tab_widget/bu_tab_widget.dart';
import 'package:flutter/material.dart';

class AdminCandidatingPage extends StatelessWidget {
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
      body: BuTabWidget(
        tabItems: tabItems,
        pages: pages,
      ),
    );
  }
}