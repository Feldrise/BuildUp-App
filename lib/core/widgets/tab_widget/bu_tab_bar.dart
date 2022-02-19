import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/core/widgets/tab_widget/bu_tab_item.dart';
import 'package:buildup/features/main_page/page_item.dart';
import 'package:flutter/material.dart';

class BuTabBar extends StatelessWidget {
  const BuTabBar({
    Key? key, 
    required this.onSelectedTab, 
    required this.currentTabIndex, 
    required this.tabItems
  }) : super(key: key);

  final Function(PageItem) onSelectedTab;
  final int currentTabIndex;

  final List<PageItem> tabItems;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Theme.of(context).cardColor,
          child:  Row(
            children: [
              if (constraints.maxWidth > ScreenUtils.instance.breakpointTablet + 10) 
                const SizedBox(width: 35,),

              for (int i = 0; i < tabItems.length; ++i) 
                InkWell(
                  onTap: () => onSelectedTab(tabItems[i]),
                  child: BuTabItem(
                    item: tabItems[i],
                    isActive: i == currentTabIndex 
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}