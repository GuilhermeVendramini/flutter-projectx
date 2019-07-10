import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/plugins/models/plugin.dart';
import 'package:projetcx/app/plugins/types/text_columns/ui/display.dart';
import 'package:projetcx/app/plugins/types/text_columns/ui/form.dart';

final PluginModel pluginTextColumns = PluginModel(
  type: 'TEXTCOLUMNS',
  name: Strings.textColumns,
  icon: Icons.border_vertical,
  display: PluginTextColumnsFieldDisplay.build,
  form: PluginTextColumnsBuildForm(),
);
