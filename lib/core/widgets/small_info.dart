import 'package:flutter/material.dart';

class SmallInfo extends StatelessWidget {
  const SmallInfo({
    Key? key,
    required this.title, 
    required this.child,
    this.width, 
  }) : super(key: key);

  final String title;
  final Widget child;

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title.toUpperCase(), style: Theme.of(context).textTheme.caption,),
          Flexible(
            child: child,
          )
        ],
      ),
    );
  }
}