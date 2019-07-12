import 'package:simpleslider/app/plugins/models/plugin.dart';
import 'package:simpleslider/app/plugins/types/imagefield/plugin.dart';
import 'package:simpleslider/app/plugins/types/text_columns/plugin.dart';
import 'package:simpleslider/app/plugins/types/textarea/plugin.dart';
import 'package:simpleslider/app/plugins/types/textfield/plugin.dart';
import 'package:simpleslider/app/plugins/types/textimage/plugin.dart';
import 'package:simpleslider/app/plugins/types/webview/plugin.dart';
//import 'package:simpleslider/app/plugins/types/youtubefield/plugin.dart';

List<PluginModel> pluginsRegister = [
  pluginTextField,
  pluginTextArea,
  pluginImageField,
  pluginTextImage,
  //pluginYoutubeField,
  pluginTextColumns,
  pluginWebView,
];
