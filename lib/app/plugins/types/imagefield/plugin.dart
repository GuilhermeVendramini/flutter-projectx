import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/models/plugin.dart';
import 'package:projetcx/app/plugins/types/imagefield/ui/display.dart';
import 'package:projetcx/app/plugins/types/imagefield/ui/form.dart';

final PluginModel pluginImageField = PluginModel(
  type: 'IMAGEFIELD',
  name: "Image",
  icon: Icons.image,
  display: PluginImageFieldDisplay.build,
  form: PluginImageFieldBuildForm(),
);
