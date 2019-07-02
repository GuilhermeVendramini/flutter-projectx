import 'package:flutter/foundation.dart';
import 'package:projetcx/app/plugins/db/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';

class PluginController with ChangeNotifier {
  List<PluginDataModel> _items;
  bool _isItemsLoaded;
}

class Plugin extends PluginController {
  List<PluginDataModel> getItemsByParent(int parent) {
    if (parent != null) {
      Map<int, List<PluginDataModel>> _itemsByParent = {};
      _items?.forEach((item) {
        _itemsByParent.putIfAbsent(item.parent, () => []);
        _itemsByParent[item.parent].add(item);
      });

      _itemsByParent[parent]?.sort((a, b) {
        return a.weight.compareTo(b.weight);
      });
      return _itemsByParent[parent];
    }
    return null;
  }

  bool get isItemsLoaded {
    return _isItemsLoaded;
  }
}

class PluginService extends Plugin {
  action({@required dynamic item}) {
/*    switch (pluginType) {
      case 'TEXTFIELD':
        {
          return PluginTextField(item: item);
        }
        break;

      default:
        {
          return PluginNotFound();
        }
        break;
    }*/
  }

  var db = DBPlugins();

  void loadItems() async {
    if (_isItemsLoaded != null) {
      return null;
    }

    _items = await db.getAll;
    _isItemsLoaded = true;
    notifyListeners();
  }

  Future<int> addItem(Map<String, dynamic> item) async {
    PluginDataModel plugin = PluginDataModel(
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

  Future<int> updateItem(PluginDataModel plugin) {
    Future<int> result = db.update(plugin);
    return result;
  }
}
