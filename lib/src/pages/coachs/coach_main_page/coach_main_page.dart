
import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/coachs/coach_profile_page/coach_profile_page.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

class CoachMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const CoachProfilPage()
    ];
      
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