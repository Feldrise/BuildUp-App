import 'package:buildup/features/main_page/page_item.dart';
import 'package:buildup/features/main_page/widgets/menu_drawer_item.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key, 
    required this.onSelectedPage, 
    required this.shouldPop,
    required this.currentPageIndex, 
    required this.pageItems,
    this.isMinimified = false
  }) : super(key: key);

  final Function(PageItem) onSelectedPage;
  final bool shouldPop;
  final int currentPageIndex;

  final List<PageItem> pageItems;

  final bool isMinimified;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border(
            right: BorderSide(
              color: Theme.of(context).dividerColor
            ),
            top: BorderSide(
              color: Theme.of(context).dividerColor
            ),
            bottom: BorderSide(
              color: Theme.of(context).dividerColor
            )
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The buildup logo
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 64,
              child: Center(
                child: Image.asset(
                  isMinimified ? "assets/images/buildup_mini.png" : "assets/images/buildup.png",
                ),
              ),
            ),
            const SizedBox(height: 14,),

            // The list of oages
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: pageItems.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      onSelectedPage(pageItems[index]);
                      if (shouldPop) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: MenuDrawerItem(
                      item: pageItems[index],
                      isActive: index == currentPageIndex,
                      isMinimified: isMinimified, 
                    ),
                  );
                },
              ),
            ),
            // TODO: do
            // BuDrawerProfileInfo(
            //   isMinimified: isMinimified,
            // )
          ],
        ),
      ),
    );
  }
}