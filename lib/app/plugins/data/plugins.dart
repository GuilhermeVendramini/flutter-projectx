import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/constants/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin.dart';

List<PluginModel> pluginsData = [
  PluginModel(
    pluginType: PluginsType.TEXTFIELD,
    name: "Text Field",
    icon: Icons.title,
  ),
  PluginModel(
    pluginType: PluginsType.TEXTAREA,
    name: "Text Area",
    icon: Icons.text_fields,
  ),
  PluginModel(
    pluginType: PluginsType.IMAGE,
    name: "Image",
    icon: Icons.image,
  ),
  PluginModel(
    pluginType: PluginsType.VIDEO,
    name: "Video",
    icon: Icons.video_library,
  ),
  PluginModel(
    pluginType: PluginsType.GALLERY,
    name: "Gallery",
    icon: Icons.view_carousel,
  ),
  PluginModel(
    pluginType: PluginsType.CONTACT,
    name: "Contacts",
    icon: Icons.contact_phone,
  ),
];
