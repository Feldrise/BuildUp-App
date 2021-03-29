import 'package:flutter/material.dart';

class TabItem {
  TabItem({
    required this.index, 
    required this.title, 
    this.icon,
    this.suffixWidget
  });

  final int index;
  final String title;
  final IconData? icon;

  final Widget? suffixWidget;
}