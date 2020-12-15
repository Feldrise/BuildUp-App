import 'package:flutter/material.dart';

class BuCheckBox extends StatelessWidget {
  const BuCheckBox({
    Key key,
    @required this.value,
    @required this.onChanged,
    @required this.text
  }) : super(key: key);


  final bool value;
  final Function(bool) onChanged;
  
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Flexible(child: Text(text, style: Theme.of(context).textTheme.caption,))
      ],
    );
  }
}