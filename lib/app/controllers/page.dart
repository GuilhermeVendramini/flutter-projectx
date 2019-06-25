import 'package:flutter/material.dart';
import 'package:projetcx/app/db/page.dart';
import 'package:projetcx/app/models/page.dart';

class PageController with ChangeNotifier {
  List<PageModel> _items = [];
  bool _isItemsLoaded;
}

class Page extends PageController {
  List<PageModel> get getItems {
    _items.sort((a, b) {
      return a.weight.compareTo(b.weight);
    });
    return _items;
  }

  bool get isItemsLoaded {
    return _isItemsLoaded;
  }
}

class PageService extends Page {
  var db = DBPage();

  loadItems() async {
    if (_isItemsLoaded != null) {
      return null;
    }

    _items = await db.getAll;
    _isItemsLoaded = true;
    notifyListeners();
    return null;
  }

  addItem(Map<String, dynamic> page) {
    db.insert(
      PageModel(
        name: page['name'] != '' ? page['name'] : 'Page',
        color: page['color'],
        weight: 0,
      ),
    );
    _isItemsLoaded = null;
    notifyListeners();
  }

  updateItem(Map<String, dynamic> page) {
    db.update(
      PageModel(
        id: page['id'],
        name: page['name'] != null ? page['name'] : 'Page',
        color: page['color'],
        weight: page['weight'],
      ),
    );
  }
}
