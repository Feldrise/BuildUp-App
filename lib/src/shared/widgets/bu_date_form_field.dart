import 'package:buildup/src/shared/widgets/bu_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuDateFormField extends FormField<DateTime> {
  BuDateFormField({
    Key key,
    @required BuildContext context,
    FormFieldSetter<DateTime> onSave,
    FormFieldValidator<DateTime> validator,
    DateTime initialValue,
    @required DateTime firstDate,
    @required DateTime lastDate,
    SelectableDayPredicate selectableDayPredicate,
    String label = "Date",
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled
  }) : super(
    key: key,
    onSaved: onSave,
    validator: validator,
    initialValue: initialValue,
    autovalidateMode: autovalidateMode,
    builder: (FormFieldState<DateTime> state) {
      final DateTime currentValue = state.value;
      final String currentValueString = currentValue != null ? DateFormat("dd/MM/yyyy").format(currentValue) : "";

      return GestureDetector(
        onTap: () async {
          final DateTime newDate = await showDatePicker(
            context: context,
            firstDate: firstDate,
            lastDate: lastDate,
            initialDate: currentValue ?? initialValue ?? DateTime.now(),
            helpText: label,
            selectableDayPredicate: selectableDayPredicate,
          );

          if (newDate != null) {
            state.reset();
            state.didChange(newDate);
          }
        },
        child: AbsorbPointer(
          child: BuTextField(
            controller: TextEditingController()..text = currentValueString,
            onChanged: (value) {},
            labelText: label,
            hintText: "Date",
            readOnly: true, 
            suffixIcon: Icons.date_range,
          ),
        ),
      );
    }
  );
}