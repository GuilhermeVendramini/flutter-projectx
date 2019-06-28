import 'package:flutter/foundation.dart';
import 'package:projetcx/app/plugins/constants/plugins.dart';
import 'package:projetcx/app/plugins/types/textarea/ui/plugin.dart';
import 'package:projetcx/app/plugins/types/textfield/ui/plugin.dart';
import 'package:projetcx/app/plugins/ui/not_found.dart';

class PluginsController {
  PluginsController._();

  static action({@required PluginsType pluginType}) {
    switch (pluginType) {
      case PluginsType.TEXTFIELD:
        {
          return PluginTypeTextField();
        }
        break;

      case PluginsType.TEXTAREA:
        {
          return PluginTypeTextArea();
        }
        break;

      default:
        {
          return PluginNotFound();
        }
        break;
    }
  }
}
