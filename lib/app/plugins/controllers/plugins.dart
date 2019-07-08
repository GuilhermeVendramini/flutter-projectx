import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/db/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';

class PluginController with ChangeNotifier {
  List<PluginDataModel> _items;
  bool _isItemsLoaded;
  PageModel _currentParent;
  PluginDataModel _currentItem;
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

  PageModel get getCurrentParent {
    return _currentParent;
  }

  PluginDataModel get getCurrentItem {
    return _currentItem;
  }
}

class PluginService extends Plugin {
  var db = DBPlugins();

  void loadItems() async {
    if (_isItemsLoaded != null) {
      return null;
    }

    _items = await db.getAll;
    _isItemsLoaded = true;
    notifyListeners();
  }

  void setCurrentParent(PageModel item) {
    _currentParent = item;
  }

  void setCurrentItem(PluginDataModel item) {
    _currentItem = item;
  }

  Future<int> addItem(Map<String, dynamic> item) async {
    PluginDataModel plugin = PluginDataModel(
      type: item['type'],
      parent: item['parent'],
      data: json.decode(json.encode(item['data'])),
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
    result.then((itemId) {
      int index = _items.indexWhere((item) => item.id == plugin.id);
      _items[index] = plugin;
    });
    _currentItem = null;
    return result;
  }

  Future<int> deleteItem(PluginDataModel plugin) {
    Future<int> result = db.delete(plugin);
    result.then((itemId) {
      _items.removeWhere((item) => item.id == plugin.id);
    });
    return result;
  }
}
