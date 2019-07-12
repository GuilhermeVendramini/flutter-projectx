import 'package:flutter/material.dart';
import 'package:simpleslider/app/constants/strings.dart';
import 'package:simpleslider/app/plugins/models/plugin.dart';
import 'package:simpleslider/app/plugins/types/textfield/ui/display.dart';
import 'package:simpleslider/app/plugins/types/textfield/ui/form.dart';

final PluginModel pluginTextField = PluginModel(
  type: 'TEXTFIELD',
  name: Strings.title,
  icon: Icons.title,
  display: PluginTextFieldDisplay.build,
  form: PluginTextFieldBuildForm(),
);
