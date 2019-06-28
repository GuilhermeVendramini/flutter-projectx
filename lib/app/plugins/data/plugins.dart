import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/constants/plugins.dart';
import 'package:projetcx/app/plugins/models/plugins.dart';

List<PluginsModel> pluginsData = [
  PluginsModel(
    pluginType: PluginsType.TEXTFIELD,
    name: "Text Field",
    icon: Icons.title,
  ),
  PluginsModel(
    pluginType: PluginsType.TEXTAREA,
    name: "Text Area",
    icon: Icons.text_fields,
  ),
  PluginsModel(
    pluginType: PluginsType.IMAGE,
    name: "Image",
    icon: Icons.image,
  ),
  PluginsModel(
    pluginType: PluginsType.VIDEO,
    name: "Video",
    icon: Icons.video_library,
  ),
  PluginsModel(
    pluginType: PluginsType.GALLERY,
    name: "Gallery",
    icon: Icons.view_carousel,
  ),
  PluginsModel(
    pluginType: PluginsType.CONTACT,
    name: "Contacts",
    icon: Icons.contact_phone,
  ),
];
