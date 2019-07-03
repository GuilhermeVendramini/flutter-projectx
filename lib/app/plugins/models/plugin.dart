import 'package:flutter/material.dart';

class PluginModel {
  String type;
  String name;
  IconData icon;
  Function display;
  Widget form;

  PluginModel({
    @required this.type,
    @required this.name,
    @required this.icon,
    @required this.display,
    @required this.form,
  });
}
