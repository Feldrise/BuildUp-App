import 'package:flutter/material.dart';

class PageItem {
  PageItem({
    @required this.index, 
    @required this.title, 
    @required this.icon,
    this.suffixWidget
  });

  final int index;
  final String title;
  final IconData icon;

  final Widget suffixWidget;
}