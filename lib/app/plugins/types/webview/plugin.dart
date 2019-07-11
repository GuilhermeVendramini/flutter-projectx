import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/plugins/models/plugin.dart';
import 'package:projetcx/app/plugins/types/webview/ui/display.dart';
import 'package:projetcx/app/plugins/types/webview/ui/form.dart';

final PluginModel pluginWebView = PluginModel(
  type: 'WEBVIEW',
  name: Strings.url,
  icon: Icons.link,
  display: PluginWebViewDisplay.build,
  form: PluginWebViewBuildForm(),
);
