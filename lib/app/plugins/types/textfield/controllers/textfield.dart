/*
import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/constants/plugins.dart';
import 'package:projetcx/app/plugins/db/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';

class PluginTextFieldController with ChangeNotifier {
  List<PluginDataModel> _items = [];
}

class PluginTextField extends PluginTextFieldController {
  */
/*
  * Under development
  */ /*

}

class PluginTextFieldService extends PluginTextField {
  var db = DBPlugins();

  Future<int> addItem(Map<String, dynamic> item) {
    PluginDataModel plugin = PluginDataModel(
      type: PluginsType.TEXTFIELD.toString(),
      parent: item['parent'],
      value: item['value'],
      weight: 0,
    );
    Future<int> result = db.insert(plugin);
    result.then((itemId) {
      plugin.id = itemId;
      _items.add(plugin);
    });
    return result;
  }
}
*/
