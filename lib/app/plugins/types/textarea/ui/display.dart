import 'package:flutter/material.dart';

class PluginTextAreaDisplay {
  PluginTextAreaDisplay._();

  static build(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 20.0,
      ),
    );
  }
}
