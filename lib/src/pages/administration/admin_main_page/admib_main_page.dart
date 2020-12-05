import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/administration/admin_main_page/admin_candidating_pages/admin_candidating_page.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

class AdminMainPage extends StatelessWidget {
  final List<PageItem> pageItems = [
    PageItem(
      index: 0, 
      title: "Candidature", 
      icon: Icons.book,
      suffixWidget: const Text("6")
    ),
    PageItem(
      index: 1, 
      title: "Membres Actifs", 
      icon: Icons.person,
    ),
  ];

  final List<Widget> pages = [
    AdminCandidatingPage(),
    const Center(child: Text("Hello Membres Actifs",)),
  ];

  @override
  Widget build(BuildContext context) {
    return MainPage(
      pageItems: pageItems, 
      pages: pages
    );
  }
}