import 'package:flutter/material.dart';

class BuTextField extends StatefulWidget {
  const BuTextField({
    Key? key,
    this.formKey,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    required this.controller,
    required this.validator,
    required this.labelText,
    this.suffixIcon,
    this.hintText,
    this.maxLines = 1,
    this.onSaved,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  final Key? formKey;

  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String)? validator;
  final Function(String)? onSaved;
  final Function(String?)? onChanged;

  final IconData? suffixIcon;
  final String? hintText;
  final String labelText;

  final TextInputType inputType;
  final int maxLines;

  final bool readOnly;

  @override
  _BuTextFieldState createState() => _BuTextFieldState();
}

class _BuTextFieldState extends State<BuTextField> {
  bool _obscureText = false;

  void _initialize() {
    _obscureText = widget.obscureText;
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant BuTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.labelText.toUpperCase(), style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 12),),
        const SizedBox(height: 10.0,),
        TextFormField(
          readOnly: widget.readOnly,
          key: widget.formKey,
          obscureText: _obscureText,
          controller: widget.controller,
          keyboardType: widget.inputType,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).textTheme.bodyText1!.color!,),
              borderRadius: BorderRadius.circular(6.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).textTheme.bodyText1!.color!,),
              borderRadius: BorderRadius.circular(6.0),
            ),
            suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : !widget.obscureText ? null : InkWell(
              onTap: _textVisibilityUpdated,
              child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            )
          ),
          validator: widget.validator == null ? null : (value) => widget.validator!(value ?? ""),
          onSaved: widget.onSaved != null ? (value) => widget.onSaved!(value ?? "") : null,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          }
        ),
      ],
    );
  }

  void _textVisibilityUpdated() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}