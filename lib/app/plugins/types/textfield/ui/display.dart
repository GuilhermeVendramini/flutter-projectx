import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/types/textfield/models/textfield.dart';

class PluginTextFieldDisplay {
  PluginTextFieldDisplay._();

  static build(Map<String, dynamic> data) {
    final TextFieldModel _data = TextFieldModel.fromJson(data);
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Text(
        _data.title,
        style: TextStyle(
          fontSize: 60.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
