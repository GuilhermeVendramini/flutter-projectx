import 'package:flutter/material.dart';

class PluginTextFieldDisplay {
  PluginTextFieldDisplay._();

  static build(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 80.0,
      ),
    );
  }
}
