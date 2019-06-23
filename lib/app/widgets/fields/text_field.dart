import 'package:flutter/material.dart';

class FieldTextField extends StatelessWidget {
  final String hintText;
  final bool autoFocus;

  FieldTextField({this.hintText, this.autoFocus: false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
      ),
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 36.0,
      ),
    );
  }
}
