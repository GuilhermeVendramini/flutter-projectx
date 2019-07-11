import 'package:projetcx/app/plugins/models/plugin.dart';
import 'package:projetcx/app/plugins/types/imagefield/plugin.dart';
import 'package:projetcx/app/plugins/types/text_columns/plugin.dart';
import 'package:projetcx/app/plugins/types/textarea/plugin.dart';
import 'package:projetcx/app/plugins/types/textfield/plugin.dart';
import 'package:projetcx/app/plugins/types/textimage/plugin.dart';
import 'package:projetcx/app/plugins/types/webview/plugin.dart';
//import 'package:projetcx/app/plugins/types/youtubefield/plugin.dart';

List<PluginModel> pluginsRegister = [
  pluginTextField,
  pluginTextArea,
  pluginImageField,
  pluginTextImage,
  //pluginYoutubeField,
  pluginTextColumns,
  pluginWebView,
];
