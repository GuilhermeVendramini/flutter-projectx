import 'dart:io';

import 'package:flutter/material.dart';

class PluginImageFieldDisplay {
  PluginImageFieldDisplay._();

  static build(String value) {
    final _file = File(value);
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Image.file(_file),
    );
  }
}
