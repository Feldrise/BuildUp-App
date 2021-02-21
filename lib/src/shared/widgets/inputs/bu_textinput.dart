import 'package:flutter/material.dart';

class BuTextInput extends StatefulWidget {
  const BuTextInput({
    Key key,
    this.formKey,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    @required this.controller,
    @required this.validator,
    @required this.labelText,
    this.suffixIcon,
    this.hintText,
    this.maxLines = 1,
    this.onSaved,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  final Key formKey;

  final bool obscureText;
  final TextEditingController controller;
  final String Function(String) validator;
  final Function(String) onSaved;
  final Function(String) onChanged;

  final IconData suffixIcon;
  final String labelText;
  final String hintText;

  final TextInputType inputType;
  final int maxLines;

  final bool readOnly;

  @override
  _BuTextInputState createState() => _BuTextInputState();
}

class _BuTextInputState extends State<BuTextInput> {
  bool _obscureText;

  @override
  void initState() {
    super.initState();

    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant BuTextInput oldWidget) {
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
        TextFormField(
          readOnly: widget.readOnly,
            key: widget.formKey,
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
              suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : !widget.obscureText ? null : InkWell(
                onTap: _textVisibilityUpdated,
                child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              )
            ),
            validator: widget.validator,
            onSaved: widget.onSaved,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged(value);
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