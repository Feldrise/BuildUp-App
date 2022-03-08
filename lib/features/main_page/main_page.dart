import 'package:buildup/features/main_page/page_item.dart';
import 'package:buildup/features/main_page/widgets/menu_drawer.dart';
import 'package:buildup/theme/bu_theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.pageItems,
    required this.pages
  }) : assert(pageItems.length == pages.length, "you don't have the same pageItems number than the pages number"), super(key: key);

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
      onWillPop: () async {
        // TODO: do
        // show confirmation
        // return (await AppManager.instance.showCloseAppConfirmation(context)) ?? false;
        return true;
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
                  child: MenuDrawer(
                    pageItems: widget.pageItems,
                    currentPageIndex: _currentIndex,
                    onSelectedPage: _selectedPage,
                    shouldPop: false,
                    isMinimified: _isMenuBarMinimified,
                  ),
                ),

              Expanded(
                child: Scaffold(
                  appBar:AppBar(
                    title: Text(widget.pageItems[_currentIndex].title),
                    leading: constraints.maxWidth < withForShowedDrawer ? null : IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        setState(() {
                          _isMenuBarMinimified = !_isMenuBarMinimified;
                        });
                      },
                    ),
                  ),
                  drawer: (constraints.maxWidth <= withForShowedDrawer) 
                  ? MenuDrawer(
                    pageItems: widget.pageItems,
                    currentPageIndex: _currentIndex,
                    onSelectedPage: _selectedPage,
                    shouldPop: true,
                  )
                  : null,
                  body: Theme(
                    data: Theme.of(context).copyWith(
                      appBarTheme: BuTheme.themeSecondAppBarDark(context)
                    ),
                    child: widget.pages[_currentIndex]
                  ),
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