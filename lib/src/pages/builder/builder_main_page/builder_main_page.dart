
import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

class BuilderMainPage extends StatelessWidget {
  final List<Widget> pages = [
    const Center(child: Text("Hello Profil"),),
  ];

  @override
  Widget build(BuildContext context) {
      
    final List<PageItem> pageItems = [
      PageItem(
        index: 0, 
        title: "Profil", 
        icon: Icons.account_circle,
      ),
    ];

    return MainPage(
      pageItems: pageItems, 
      pages: pages
    );
  }
}