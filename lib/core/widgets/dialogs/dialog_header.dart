import 'package:flutter/material.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader({
    Key? key,
    required this.title
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).dividerColor
          )
        )
      ),
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        children: [
          // The title
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.headline4,),
          ),
          const SizedBox(width: 8.0,),

          // The closing button
          IconButton(
            icon: const Icon(Icons.close),
            iconSize: 22,
            color: Theme.of(context).textTheme.bodyText1!.color,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}