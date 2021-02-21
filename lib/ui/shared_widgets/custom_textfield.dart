import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    @required this.controller,
    @required this.title,
    this.hideText = false,
    this.length = 1,
    this.inputBorder = const OutlineInputBorder(),
    this.keyboardType = TextInputType.text,
    this.maxLine = 1,
    this.showUnderLine = true,
  });

  final TextEditingController controller;
  final bool hideText;
  final String title;
  final int length;
  final InputBorder inputBorder;
  final TextInputType keyboardType;
  final int maxLine;
  final bool showUnderLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hideText,
      validator: (String value) {
        if (value.trim().isEmpty) {
          return "$title Can't Be Empty";
        } else if (value.trim().length < length) {
          return "$title Can't Be Less Than $length Character";
        } else {
          return null;
        }
      },
      decoration: showUnderLine
          ? InputDecoration(
              border: inputBorder,
              hintText: title,
              fillColor: Colors.white70,
              filled: true,
            )
          : InputDecoration.collapsed(
              hintText: title,
              fillColor: Colors.white70,
              filled: true,
            ),
      keyboardType: keyboardType,
      maxLines: maxLine,
    );
  }
}
