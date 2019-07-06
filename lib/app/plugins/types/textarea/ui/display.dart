import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/types/textarea/models/textarea.dart';

class PluginTextAreaDisplay {
  PluginTextAreaDisplay._();

  static build(Map<String, dynamic> data) {
    final TextAreaModel _data = TextAreaModel.fromJson(data);
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Text(
        _data.text,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
