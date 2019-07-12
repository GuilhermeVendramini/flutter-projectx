import 'package:flutter/material.dart';
import 'package:simpleslider/app/constants/strings.dart';
import 'package:simpleslider/app/plugins/models/plugin.dart';
import 'package:simpleslider/app/plugins/types/imagefield/ui/display.dart';
import 'package:simpleslider/app/plugins/types/imagefield/ui/form.dart';

final PluginModel pluginImageField = PluginModel(
  type: 'IMAGEFIELD',
  name: Strings.image,
  icon: Icons.image,
  display: PluginImageFieldDisplay.build,
  form: PluginImageFieldBuildForm(),
);
