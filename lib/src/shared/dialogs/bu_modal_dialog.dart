import 'package:buildup/utils/colors.dart';
import 'package:flutter/material.dart';

class BuModalDialog extends StatelessWidget {
  const BuModalDialog({
    Key key, 
    @required this.title, 
    @required this.content, 
    @required this.actions
  }) : super(key: key);

  final String title;

  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: const Border(
            top: BorderSide(
              width: 4,
              color: colorPrimary
            )
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title, style: Theme.of(context).textTheme.headline4,)
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 28,),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            const Divider(),
            const SizedBox(height: 30,),
            Flexible(child: SingleChildScrollView(child: content)),
            const SizedBox(height: 40,),
            if (MediaQuery.of(context).size.width > 476) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: actions,
            ) 
            else Column(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            )
          ]
        )
      )
    );
  }
}