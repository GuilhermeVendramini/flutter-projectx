import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/plugins/models/plugin.dart';
import 'package:projetcx/app/plugins/types/youtubefield/ui/display.dart';
import 'package:projetcx/app/plugins/types/youtubefield/ui/form.dart';

final PluginModel pluginYoutubeField = PluginModel(
  type: 'YOUTUBEFIELD',
  name: Strings.youtube,
  icon: Icons.video_library,
  display: PluginYoutubeFieldDisplay.build,
  form: PluginYoutubeFieldBuildForm(),
);
