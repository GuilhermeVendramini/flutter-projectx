import 'package:flutter/material.dart';
import 'package:simpleslider/app/constants/strings.dart';
import 'package:simpleslider/app/plugins/models/plugin.dart';
import 'package:simpleslider/app/plugins/types/text_columns/ui/display.dart';
import 'package:simpleslider/app/plugins/types/text_columns/ui/form.dart';

final PluginModel pluginTextColumns = PluginModel(
  type: 'TEXTCOLUMNS',
  name: Strings.textColumns,
  icon: Icons.pause,
  display: PluginTextColumnsFieldDisplay.build,
  form: PluginTextColumnsBuildForm(),
);
