import 'package:buildup/entities/page_item.dart';
import 'package:buildup/src/pages/main_page/widgets/bu_page_item.dart';
import 'package:flutter/material.dart';

class BuMenuDrawer extends StatelessWidget {
  const BuMenuDrawer({
    Key key, 
    @required this.onSelectedPage, 
    @required this.shouldPop,
    @required this.currentPageIndex, 
    @required this.pageItems
  }) : super(key: key);

  final ValueChanged<PageItem> onSelectedPage;
  final bool shouldPop;
  final int currentPageIndex;

  final List<PageItem> pageItems;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(
              color: Color(0xffedeff0)
            ),
            top: BorderSide(
              color: Color(0xffedeff0)
            ),
            bottom: BorderSide(
              color: Color(0xffedeff0)
            )
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 64,
              child: Center(
                child: Image.asset(
                  "assets/icons/icon_buildup.png",

                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: pageItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onSelectedPage(pageItems[index]);
                    if (shouldPop) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: BuPageItem(
                    item: pageItems[index],
                    isActive: index == currentPageIndex 
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}