import 'package:flutter/material.dart';
import 'package:projetcx/app/db/page.dart';
import 'package:projetcx/app/models/page.dart';

class PageController with ChangeNotifier {
  List<PageModel> _items;
  bool _isItemsLoaded;
  Map<int, List<PageModel>> _itemsByCategory;
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

  List<PageModel> getItemsByCategory(int categoryId) {
    _itemsByCategory = {};
    if (categoryId != null) {
      _items?.forEach((item) {
        _itemsByCategory.putIfAbsent(item.category, () => []);
        _itemsByCategory[item.category].add(item);
      });

      _itemsByCategory[categoryId]?.sort((a, b) {
        return a.weight.compareTo(b.weight);
      });
      return _itemsByCategory[categoryId];
    }
    return null;
  }

  int getItemIndex(PageModel page, int category) {
    print(_itemsByCategory[category]);
    int index = _itemsByCategory[category].indexWhere((item) => item.id == page?.id);
    print(index);
    return index;
  }

  void notifyChange() {
    notifyListeners();
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
      category: item['category'],
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
    });
    return result;
  }
}
