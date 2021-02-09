import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/candidating_process/candidating_process_page/candidating_process_page.dart';
import 'package:buildup/src/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

class CandidatingProcessMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CandidatingProcessPage(),
    ];

      
    final List<PageItem> pageItems = [
      PageItem(
        index: 0, 
        title: "Candidature", 
        icon: Icons.library_books,
      ),
    ];

    return MainPage(
      pageItems: pageItems, 
      pages: pages,
    );
  }
}