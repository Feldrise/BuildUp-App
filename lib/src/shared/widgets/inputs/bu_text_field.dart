import 'package:flutter/material.dart';

class BuTextField extends StatefulWidget {
  const BuTextField({
    Key key,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    @required this.controller,
    @required this.labelText,
    @required this.onChanged,
    this.suffixIcon,
    this.hintText,
    this.maxLines = 1,
    this.readOnly = false,
  }) : super(key: key);
  final bool obscureText;
  final TextEditingController controller;
  final Function(String) onChanged;

  final IconData suffixIcon;
  final String labelText;
  final String hintText;

  final TextInputType inputType;
  final int maxLines;

  final bool readOnly;

  @override
  _BuTextFieldState createState() => _BuTextFieldState();
}

class _BuTextFieldState extends State<BuTextField> {
  bool _obscureText;

  @override
  void initState() {
    super.initState();

    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant BuTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.labelText.toUpperCase(), style: const TextStyle(color: Colors.black54, fontSize: 12),),
        const SizedBox(height: 10.0,),
        TextField(
          readOnly: widget.readOnly,
          obscureText: _obscureText,
          controller: widget.controller,
          keyboardType: widget.inputType,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12,),
              borderRadius: BorderRadius.circular(6.0),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12,),
              borderRadius: BorderRadius.circular(6.0),
            ),
            suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : !widget.obscureText ? null : GestureDetector(
              onTap: _textVisibilityUpdated,
              child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            )
          ),
          onChanged: widget.onChanged,
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