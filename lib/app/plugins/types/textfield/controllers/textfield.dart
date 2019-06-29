import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/constants/plugins.dart';
import 'package:projetcx/app/plugins/db/plugins.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';

class PluginTextFieldController with ChangeNotifier {
  List<PluginDataModel> _items = [];
 /* List<PageModel> _items;
  bool _isItemsLoaded;*/
}

class PluginTextField extends PluginTextFieldController {
/*  List<PageModel> get getItems {
    if (_items != null) {
      _items.sort((a, b) {
        return a.weight.compareTo(b.weight);
      });
    }
    return _items;
  }

  bool get isItemsLoaded {
    return _isItemsLoaded;
  }*/
}

class PluginTextFieldService extends PluginTextField {
  var db = DBPlugins();

  Future<int> addItem(Map<String, dynamic> item) {
    PluginDataModel page = PluginDataModel(
      type: PluginsType.TEXTFIELD.toString(),
      parent: item['parent'],
      value: item['value'],
      weight: 0,
    );
    Future<int> result = db.insert(page);
    result.then((itemId) {
      print('Item add $itemId');
      page.id = itemId;
      _items.add(page);
    });
    return result;
  }
/*  var db = DBPage();

  loadItems() async {
    if (_isItemsLoaded != null) {
      return null;
    }

    _items = await db.getAll;
    _isItemsLoaded = true;
    notifyListeners();
    return null;
  }

  Future<int> addItem(Map<String, dynamic> item) {
    PageModel page = PageModel(
      name: item['name'] != '' ? item['name'] : 'Page',
      color: item['color'],
      weight: 0,
    );
    Future<int> result = db.insert(page);
    result.then((itemId) {
      page.id = itemId;
      _items.add(page);
    });
    return result;
  }

  Future<int> updateItem(PageModel page) {
    Future<int> result = db.update(page);
    return result;
  }

  updateItemList(PageModel page) {
    int index = _items.indexWhere((item) => item.id == page.id);
    _items.removeWhere((item) => item.id == page.id);
    _items.insert(index, page);
  }

  Future<int> deleteItem(PageModel page) {
    Future<int> result = db.delete(page);
    result.then((itemId) {
      _items.removeWhere((item) => item.id == page.id);
    });
    return result;
  }

  void notifyChange() {
    notifyListeners();
  }*/
}
