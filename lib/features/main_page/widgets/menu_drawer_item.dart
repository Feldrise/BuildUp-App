import 'package:buildup/core/utils/colors.dart';
import 'package:buildup/features/main_page/page_item.dart';
import 'package:flutter/material.dart';

class MenuDrawerItem extends StatelessWidget {
  const MenuDrawerItem({
    Key? key,
    required this.item, 
    this.isActive = false,
    this.isMinimified = false
  }) : super(key: key);

  final PageItem item;
  final bool isActive;
  final bool isMinimified;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // height: 100,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColor.withOpacity(0.1) : Theme.of(context).cardColor,
            border: !isActive ? null : Border(
              left: BorderSide(width: 4, color: Theme.of(context).primaryColor)
            )
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: isActive 
              ? Theme.of(context).primaryColor 
              : Theme.of(context).textTheme.bodyText2!.color,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    item.icon, 
                    size: 20, 
                    color: isActive 
                    ? Theme.of(context).primaryColor 
                    : Theme.of(context).textTheme.bodyText2!.color,
                  ),
                ),
                if (!isMinimified) ...{
                  Expanded(
                    flex: 8,
                    child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                  ),
                  if (item.suffixWidget != null) 
                    Expanded(
                      child: item.suffixWidget!,
                    )
                }
              ],
            ),
          ),
        ),
        if (isMinimified && item.suffixWidget != null)
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor
              ),
              child: Center(
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  child: item.suffixWidget!,
                ),
              ),
            ),
          )
      ],
    );
  }
}