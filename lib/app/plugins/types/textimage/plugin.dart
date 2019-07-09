import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/plugins/models/plugin.dart';
import 'package:projetcx/app/plugins/types/textimage/ui/display.dart';
import 'package:projetcx/app/plugins/types/textimage/ui/form.dart';

final PluginModel pluginTextImage = PluginModel(
  type: 'TEXTIMAGE',
  name: Strings.textImage,
  icon: Icons.art_track,
  display: PluginTextImageFieldDisplay.build,
  form: PluginTextImageBuildForm(),
);
