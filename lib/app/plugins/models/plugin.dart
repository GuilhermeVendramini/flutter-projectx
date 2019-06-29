import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/constants/plugins.dart';

class PluginModel {
  PluginsType pluginType;
  String name;
  IconData icon;

  PluginModel({
    @required this.pluginType,
    @required this.name,
    @required this.icon,
  });
}
