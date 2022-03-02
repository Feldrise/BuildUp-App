import 'package:buildup/features/active_users/active_users_page.dart';
import 'package:buildup/features/candidating_users/candidating_users_page.dart';
import 'package:buildup/features/main_page/main_page.dart';
import 'package:buildup/features/main_page/page_item.dart';
import 'package:flutter/material.dart';

class AdminMainPage extends StatelessWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The pages
    final List<Widget> pages = [
      const CandidatingUsers(),
      ClipRect(
        child: Navigator(
        onGenerateRoute: (route) => MaterialPageRoute<void>(
          settings: route,
          builder: (context) => const ActiveUsers()),
        )
      ),
    ];

    // The menu items
    const List<PageItem> pageItems = [
      // Candidating users
      PageItem(
        index: 0, 
        title: "Candidatures",
        icon: Icons.library_books
      ),
      // Active users
      PageItem(
        index: 1, 
        title: "Membres actifs", 
        icon: Icons.person
      ),
    ];

    return MainPage(
      pageItems: pageItems, 
      pages: pages
    );
  }
}