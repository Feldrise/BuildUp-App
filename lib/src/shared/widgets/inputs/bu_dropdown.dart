import 'package:flutter/material.dart';

class BuDropdown<T> extends StatelessWidget {
  const BuDropdown({
    Key key,
    @required this.items, 
    @required this.currentValue, 
    @required this.onChanged,
    this.label,
  }) : super(key: key);

  final Map<T, String> items;
  final T currentValue;

  final String label;

  final Function(T) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...{
          Text(label.toUpperCase(), style: const TextStyle(color: Colors.black54, fontSize: 12),),
          const SizedBox(height: 10.0,),
        },
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            )
          ),
          child: DropdownButton<T>(
            value: currentValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 32,
            underline: Container(),
            isExpanded: true,
            onChanged: onChanged,
            items: [
              for (final key in items.keys) 
                DropdownMenuItem(
                  value: key,
                  child: Text(items[key]),
                )
            ],
          ),
        ),
      ],
    );
  }
}