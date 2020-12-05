import 'package:buildup/entities/tab_item.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class BuTabItem extends StatelessWidget {
  const BuTabItem({
    Key key,
    @required this.item,
    this.isActive = false
  }) : super(key: key);

  final TabItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      decoration: BoxDecoration(
        color: isActive ? colorScaffoldGrey : colorScaffolddWhite,
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
            child: Text(item.title.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isActive ? colorPrimary : colorBlack),),
          )
        ],
      ),
    );
  }
}