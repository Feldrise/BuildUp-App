import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/main_page/widgets/bu_menu_drawer.dart';
import 'package:buildup/src/shared/widgets/general/bu_appbar.dart';
import 'package:buildup/utils/app_manager.dart';
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

  bool _isMenuBarMinimified = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // show confirmation
        return AppManager.instance.showCloseAppConfirmation(context);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double withForShowedDrawer = 732;

          return Row(
            children: [
              if (constraints.maxWidth > withForShowedDrawer) 
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isMenuBarMinimified ? 68 : 300,
                  child: BuMenuDrawer(
                    pageItems: widget.pageItems,
                    currentPageIndex: _currentIndex,
                    onSelectedPage: _selectedPage,
                    shouldPop: false,
                    isMinimified: _isMenuBarMinimified,
                  ),
                ),

              Expanded(
                child: Scaffold(
                  appBar: BuAppBar(
                    title: Text(widget.pageItems[_currentIndex].title),
                    showMinimifier: constraints.maxWidth > withForShowedDrawer,
                    onMinimified: () {
                      setState(() {
                        _isMenuBarMinimified = !_isMenuBarMinimified;
                      });
                    },
                  ),
                  drawer: (constraints.maxWidth <= withForShowedDrawer) 
                  ? BuMenuDrawer(
                    pageItems: widget.pageItems,
                    currentPageIndex: _currentIndex,
                    onSelectedPage: _selectedPage,
                    shouldPop: true,
                  )
                  : null,
                  body: widget.pages[_currentIndex],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _selectedPage(PageItem pageItem) {
    setState(() {
      _currentIndex = pageItem.index;
    });
  }
}