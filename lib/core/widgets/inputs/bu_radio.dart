import 'package:flutter/material.dart';

class BuRadio<T> extends StatelessWidget {
  const BuRadio({
    Key? key, 
    required this.label,
    required this.value,
    required this.onChanged,
    this.groupValue,
  }) : super(key: key);

  final String label;

  final T value;
  final T? groupValue;

  final Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // The radio widget
        Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 5,),

        // The label
        Text(label)
      ],
    );
  }
}