import 'package:buildup/entities/tab_item.dart';
import 'package:buildup/src/shared/widgets/bu_tab_widget/bu_tabbar.dart';
import 'package:flutter/material.dart';

class BuTabWidget extends StatefulWidget {
  const BuTabWidget({
    Key key, 
    @required this.tabItems,
    @required this.pages
  }) : assert(tabItems.length == pages.length, "You don't have the same tabItems number than the pages number"), super(key: key);

  final List<TabItem> tabItems;
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
        BuTabBar(
          onSelectedTab: _selectedTab, 
          currentTabIndex: _currentIndex, 
          tabItems: widget.tabItems
        ),
        Expanded(
          child: widget.pages[_currentIndex],
        )
      ],
    );
  }

  void _selectedTab(TabItem tabItem) {
    setState(() {
      _currentIndex = tabItem.index;
    });
  }
}