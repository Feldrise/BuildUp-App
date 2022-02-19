import 'package:buildup/core/widgets/tab_widget/bu_tab_bar.dart';
import 'package:buildup/features/main_page/page_item.dart';
import 'package:flutter/material.dart';

class BuTabWidget extends StatefulWidget {
  const BuTabWidget({
    Key? key, 
    required this.tabItems,
    required this.pages
  }) : assert(tabItems.length == pages.length, "You don't have the same tabItems number than the pages number"), super(key: key);

  final List<PageItem> tabItems;
  final List<Widget> pages;

  @override
  _BuTabWidgetState createState() => _BuTabWidgetState();
}

class _BuTabWidgetState extends State<BuTabWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The actual tab bar
        BuTabBar(
          onSelectedTab: _selectedTab, 
          currentTabIndex: _currentIndex, 
          tabItems: widget.tabItems
        ),

        // The widget
        Expanded(
          child: widget.pages[_currentIndex],
        )
      ],
    );
  }

  void _selectedTab(PageItem tabItem) {
    setState(() {
      _currentIndex = tabItem.index;
    });
  }
}