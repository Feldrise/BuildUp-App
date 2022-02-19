import 'package:buildup/features/main_page/page_item.dart';
import 'package:flutter/material.dart';

class BuTabItem extends StatelessWidget {
  const BuTabItem({
    Key? key,
    required this.item,
    this.isActive = false
  }) : super(key: key);

  final PageItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      decoration: BoxDecoration(
        color: isActive 
        ? Theme.of(context).scaffoldBackgroundColor 
        : Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12)
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              item.title.toUpperCase(), 
              textAlign: TextAlign.center, 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.w500, 
                color: isActive 
                  ? Theme.of(context).primaryColor  
                  : Theme.of(context).textTheme.bodyText2!.color
              ),
            ),
          )
        ],
      ),
    );
  }
}