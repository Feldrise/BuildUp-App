import 'package:flutter/material.dart';

class BuCard extends StatelessWidget {
  const BuCard({
    Key key, 
    this.height, 
    this.width, 
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),  
    @required this.child
  }) : super(key: key);

  final Widget child;

  final double height;
  final double width;

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0.0, 12.0),
            blurRadius: 5.0,
            spreadRadius: -10.0
          )
        ],
      ),
      child: child,
    );
  }
}