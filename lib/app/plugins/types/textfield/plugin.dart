import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/models/plugin.dart';
import 'package:projetcx/app/plugins/types/textfield/ui/display.dart';
import 'package:projetcx/app/plugins/types/textfield/ui/form.dart';

final PluginModel pluginTextField = PluginModel(
  type: 'TEXTFIELD',
  name: "Text Field",
  icon: Icons.title,
  display: PluginTextFieldDisplay.build,
  form: PluginTextFieldBuildForm(),
);
