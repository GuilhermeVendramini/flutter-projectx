import 'package:flutter/material.dart';

class FieldTextField extends StatelessWidget {
  final Map<String, dynamic> formData;
  final String fieldName;
  final String hintText;
  final bool autoFocus;
  final Function onSaved;
  final dynamic value;

  FieldTextField({
    this.formData,
    this.fieldName,
    this.hintText,
    this.autoFocus: false,
    this.onSaved,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      initialValue: value,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
      ),
      onSaved: onSaved,
    );
  }
}
