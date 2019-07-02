import 'package:flutter/material.dart';

class PluginModel {
  String pluginType;
  String name;
  IconData icon;
  Function display;
  Widget form;

  PluginModel({
    @required this.pluginType,
    @required this.name,
    @required this.icon,
    @required this.display,
    @required this.form,
  });
}
