import 'package:buildup/entities/tab_item.dart';
import 'package:buildup/src/shared/widgets/bu_tab_widget/bu_tab_item.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class BuTabBar extends StatelessWidget {
  const BuTabBar({
    Key key, 
    @required this.onSelectedTab, 
    @required this.currentTabIndex, 
    @required this.tabItems
  }) : super(key: key);

  final ValueChanged<TabItem> onSelectedTab;
  final int currentTabIndex;

  final List<TabItem> tabItems;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: colorScaffolddWhite,
          child:  Row(
            children: [
              if (constraints.maxWidth > 490) 
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