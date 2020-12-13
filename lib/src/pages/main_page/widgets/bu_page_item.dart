import 'package:buildup/entities/page_item.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class BuPageItem extends StatelessWidget {
  const BuPageItem({
    Key key,
    @required this.item, 
    this.isActive,
    this.isMinimified = false
  }) : super(key: key);

  final PageItem item;
  final bool isActive;
  final bool isMinimified;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xfffceff0) : Theme.of(context).cardColor,
        border: !isActive ? null : const Border(
          left: BorderSide(width: 4, color: colorPrimary)
        )
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: isActive ? colorPrimary : colorBlack,),
        child: Row(
          children: [
            Expanded(
              child: Icon(item.icon, size: 20, color: isActive ? colorPrimary : colorBlack,),
            ),
            if (!isMinimified) ...{
              Expanded(
                flex: 8,
                child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold),),
              ),
              if (item.suffixWidget != null) 
                Expanded(
                  child: item.suffixWidget,
                )
            }
          ],
        ),
      ),
    );
  }
}