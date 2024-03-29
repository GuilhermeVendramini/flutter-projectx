import 'package:flutter/material.dart';
import 'package:simpleslider/app/db/page.dart';
import 'package:simpleslider/app/models/page.dart';

class PageController with ChangeNotifier {
  List<PageModel> _items;
  bool _isItemsLoaded;
}

class Page extends PageController {
  List<PageModel> get getItems {
    if (_items != null) {
      _items.sort((a, b) {
        return a.weight.compareTo(b.weight);
      });
    }
    return _items;
  }

  int getItemIndex(PageModel page) {
    int index = _items.indexWhere((item) => item.id == page?.id);
    return index;
  }

  bool get isItemsLoaded {
    return _isItemsLoaded;
  }
}

class PageService extends Page {
  var db = DBPage();

  void loadItems() async {
    if (_isItemsLoaded != null) {
      return null;
    }

    _items = await db.getAll;
    _isItemsLoaded = true;
    notifyListeners();
  }

  Future<int> addItem(Map<String, dynamic> item) async {
    PageModel page = PageModel(
      name: item['name'],
      color: item['color'],
      weight: item['weight'],
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

  void reorderItemList(PageModel page) {
    int index = _items.indexWhere((item) => item.id == page.id);
    _items.removeWhere((item) => item.id == page.id);
    _items.insert(index, page);
  }

  Future<int> deleteItem(PageModel page) {
    Future<int> result = db.delete(page);
    result.then((itemId) {
      _items.removeWhere((item) => item.id == page.id);
      notifyListeners();
    });
    return result;
  }
}
