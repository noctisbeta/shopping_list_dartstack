import 'package:flutter/material.dart';
import 'package:shopping_list/constants/colors.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    required this.onChanged,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.inverted = false,
    this.maxLength,
    super.key,
  });

  final String label;

  final int? maxLength;

  final void Function(String) onChanged;

  final TextInputType keyboardType;

  final bool inverted;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String enteredText = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      onChanged: (String value) {
        setState(() {
          enteredText = value;
        });
        widget.onChanged(value);
      },
      maxLength: widget.maxLength,
      maxLines: 1,
      buildCounter: (
        context, {
        required currentLength,
        required isFocused,
        required int? maxLength,
      }) =>
          null,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: widget.inverted ? kSecondaryColor : kQuaternaryColor,
      ),
      cursorColor: widget.inverted ? kSecondaryColor : kQuaternaryColor,
      decoration: InputDecoration(
        suffix: switch (widget.maxLength) {
          int() => Text(
              '${enteredText.length}/${widget.maxLength}',
              style: TextStyle(
                color: widget.inverted ? kQuaternaryColor : kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          null => null,
        },
        focusColor: widget.inverted ? kTernaryColor : kPrimaryColor,
        hoverColor: widget.inverted ? kTernaryColor : kPrimaryColor,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: widget.inverted ? kQuaternaryColor : kSecondaryColor,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelStyle: TextStyle(
          color: widget.inverted ? kSecondaryColor : kQuaternaryColor,
          decorationColor: widget.inverted ? kQuaternaryColor : kSecondaryColor,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: widget.inverted ? kQuaternaryColor : kSecondaryColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: widget.inverted ? kSecondaryColor : kQuaternaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
