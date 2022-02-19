import 'package:buildup/features/active_users/active_users_page.dart';
import 'package:buildup/features/main_page/main_page.dart';
import 'package:buildup/features/main_page/page_item.dart';
import 'package:flutter/material.dart';

class AdminMainPage extends StatelessWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  final List<Widget> pages = const [
    ActiveUsers()
  ];

  @override
  Widget build(BuildContext context) {
    const List<PageItem> pageItems = [
      // Active users
      PageItem(
        index: 0, 
        title: "Membres actifs", 
        icon: Icons.person)
    ];

    return MainPage(
      pageItems: pageItems, 
      pages: pages
    );
  }
}