import 'package:flutter/material.dart';

class PluginTextFieldDisplay {
  PluginTextFieldDisplay._();

  static build(String value) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 60.0,
        ),
      ),
    );
  }
}
