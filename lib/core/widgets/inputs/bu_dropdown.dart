import 'package:flutter/material.dart';

class BuDropdown<T> extends StatelessWidget {
  const BuDropdown({
    Key? key,
    required this.items, 
    required this.currentValue, 
    required this.onChanged,
    this.stringValueController,
    this.label,
  }) : super(key: key);

  final TextEditingController? stringValueController;

  final Map<T, String> items;
  final T currentValue;

  final String? label;

  final Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The label
        if (label != null) ...{
          Text(
            label!.toUpperCase(), 
            style: Theme.of(context).textTheme.caption
          ),
          const SizedBox(height: 10.0,),
        },
        // The actual dropdown
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
            onChanged: (T? value) {
              if (stringValueController != null) {
                stringValueController!.text = value.toString();
              }

              onChanged(value);
            },
            items: [
              for (final key in items.keys) 
                DropdownMenuItem(
                  value: key,
                  child: Text(items[key] ?? "Uknonw"),
                )
            ],
          ),
        ),
      ],
    );
  }
}