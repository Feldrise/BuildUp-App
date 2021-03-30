import 'package:buildup/entities/page_item.dart';
import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class BuPageItem extends StatelessWidget {
  const BuPageItem({
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
                color: colorPrimary
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