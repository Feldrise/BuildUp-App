
import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/builder/builder_profile_page/builder_profile_page.dart';
import 'package:buildup/src/pages/builder/builder_project_page/builder_project_page.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

class BuilderMainPage extends StatelessWidget {
  final List<Widget> pages = [
    const BuilderProfilPage(),
    const BuilderProjectPage(),
  ];

  @override
  Widget build(BuildContext context) {
      
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
    ];

    return MainPage(
      pageItems: pageItems, 
      pages: pages
    );
  }
}