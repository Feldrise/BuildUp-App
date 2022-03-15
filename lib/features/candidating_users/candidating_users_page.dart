import 'package:buildup/core/widgets/tab_widget/bu_tab_widget.dart';
import 'package:buildup/features/builders/candidating_builders_page.dart';
import 'package:buildup/features/coachs/candidating_coachs_page.dart';
import 'package:buildup/features/main_page/page_item.dart';
import 'package:flutter/material.dart';

class CandidatingUsers extends StatelessWidget {
  const CandidatingUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BuTabWidget(
          tabItems: const [
            PageItem(index: 0, title: "Builders"),
            PageItem(index: 1, title: "Coachs"),
          ],
          pages: const [
            CandidatingBuildersPage(),
            CandidatingCoachsPage(),
          ]
        )
      ),
    );
  }
}