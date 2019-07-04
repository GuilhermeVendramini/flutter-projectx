import 'dart:io';

import 'package:flutter/material.dart';

class PluginImageFieldDisplay {
  PluginImageFieldDisplay._();

  static build(String value) {
    final _file = File(value);
    return Image.file(_file);
  }
}
