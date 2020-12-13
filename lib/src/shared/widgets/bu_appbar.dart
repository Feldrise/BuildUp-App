import 'package:flutter/material.dart';

class BuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BuAppBar({
    Key key, 
    this.backgroundColor,
    @required this.title,
    this.actions,
    this.preferredSize = const Size.fromHeight(64)
  }) : super(key: key);
  
  final Widget title;

  final List<Widget> actions;

  final Color backgroundColor;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: title
      ),
      actions: actions,
    );
  }
}