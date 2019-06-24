import 'package:flutter/material.dart';
import 'package:projetcx/app/db/page.dart';
import 'package:projetcx/app/models/page.dart';

class PageController with ChangeNotifier {
  List<PageModel> _items = [];
  bool _isItemsLoaded;
}

class Page extends PageController {
  List<PageModel> get getItems {
    return _items.toList();
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
    db.insertItem(
      PageModel(
        name: page['name'] != null ? page['name'] : 'Page',
        color: page['color'],
        weight: 0,
      ),
    );
    _isItemsLoaded = null;
    notifyListeners();
  }
}
