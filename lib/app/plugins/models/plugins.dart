import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/constants/plugins.dart';

class PluginsModel {
  PluginsType pluginType;
  String name;
  IconData icon;

  PluginsModel({
    @required this.pluginType,
    @required this.name,
    @required this.icon,
  });
}
