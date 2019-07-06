import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/types/imagefield/models/imagefield.dart';

class PluginImageFieldDisplay {
  PluginImageFieldDisplay._();

  static build(Map<String, dynamic> data) {
    final ImageFieldModel _data = ImageFieldModel.fromJson(data);
    final _file = File(_data.image);
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Image.file(_file),
    );
  }
}
