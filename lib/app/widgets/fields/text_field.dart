import 'package:flutter/material.dart';

class FieldTextField extends StatelessWidget {
  final Map<String, dynamic> formData;
  final String fieldName;
  final String hintText;
  final bool autoFocus;
  final Function onSaved;

  FieldTextField({
    this.formData,
    this.fieldName,
    this.hintText,
    this.autoFocus: false,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
      ),
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 36.0,
      ),
      onSaved: onSaved,
    );
  }
}
