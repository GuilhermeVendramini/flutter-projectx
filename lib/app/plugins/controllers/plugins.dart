import 'package:flutter/foundation.dart';
import 'package:projetcx/app/plugins/constants/plugins.dart';
import 'package:projetcx/app/plugins/types/textarea/ui/textarea.dart';
import 'package:projetcx/app/plugins/types/textfield/ui/textfield.dart';
import 'package:projetcx/app/plugins/ui/not_found.dart';

class PluginsController {
  PluginsController._();

  static action({@required PluginsType pluginType, dynamic item}) {
    switch (pluginType) {
      case PluginsType.TEXTFIELD:
        {
          return PluginTextField(item: item);
        }
        break;

      case PluginsType.TEXTAREA:
        {
          return PluginTextArea();
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
