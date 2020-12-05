import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/main_page/widgets/bu_menu_drawer.dart';
import 'package:buildup/src/shared/widgets/bu_appbar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key key,
    @required this.pageItems,
    @required this.pages
  }) : assert(pageItems.length == pages.length, "You don't have the same pageItems number than the pages number"), super(key: key);

  final List<PageItem> pageItems;
  final List<Widget> pages;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            if (constraints.maxWidth > 732) 
              SizedBox(
                width: 300,
                child: BuMenuDrawer(
                  pageItems: widget.pageItems,
                  currentPageIndex: _currentIndex,
                  onSelectedPage: _selectedPage,
                ),
              ),

            Expanded(
              child: Scaffold(
                appBar: BuAppBar(
                  title: Text(widget.pageItems[_currentIndex].title),
                ),
                drawer: (constraints.maxWidth <= 732) 
                ? BuMenuDrawer(
                  pageItems: widget.pageItems,
                  currentPageIndex: _currentIndex,
                  onSelectedPage: _selectedPage,
                )
                : null,
                body: widget.pages[_currentIndex],
              ),
            ),
          ],
        );
      },
    );
  }

  void _selectedPage(PageItem pageItem) {
    setState(() {
      _currentIndex = pageItem.index;
    });
  }
}