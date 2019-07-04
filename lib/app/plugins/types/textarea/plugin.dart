import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/models/plugin.dart';
import 'package:projetcx/app/plugins/types/textarea/ui/display.dart';
import 'package:projetcx/app/plugins/types/textarea/ui/form.dart';

final PluginModel pluginTextArea = PluginModel(
  type: 'TEXTAREA',
  name: "Text Area",
  icon: Icons.text_fields,
  display: PluginTextAreaDisplay.build,
  form: PluginTextAreaBuildForm(),
);
