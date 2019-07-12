import 'package:flutter/material.dart';
import 'package:projetcx/app/db/category.dart';
import 'package:projetcx/app/models/category.dart';

class CategoryController with ChangeNotifier {
  List<CategoryModel> _items;
  CategoryModel _currentCategory;
  bool _isItemsLoaded;
}

class Category extends CategoryController {
  List<CategoryModel> get getItems {
    return _items;
  }

  bool get isItemsLoaded {
    return _isItemsLoaded;
  }

  CategoryModel get getCurrentCategory {
    return _currentCategory;
  }

  int getItemIndex(CategoryModel category) {
    int index = _items.indexWhere((item) => item.id == category?.id);
    return index;
  }
}

class CategoryService extends Category {
  var db = DBPage();

  void loadItems() async {
    if (_isItemsLoaded != null) {
      return null;
    }

    _items = await db.getAll;
    _isItemsLoaded = true;
    notifyListeners();
  }

  void setCurrentCategory(CategoryModel item) {
    _currentCategory = item;
  }

  Future<int> addItem(Map<String, dynamic> item) async {
    CategoryModel category = CategoryModel(
      name: item['name'],
      color: item['color'],
      icon: item['icon'],
    );
    Future<int> result = db.insert(category);
    result.then((itemId) {
      category.id = itemId;
      _items.add(category);
    });
    return result;
  }

  Future<int> updateItem(CategoryModel category) {
    Future<int> result = db.update(category);
    return result;
  }

  Future<int> deleteItem(CategoryModel category) {
    Future<int> result = db.delete(category);
    result.then((itemId) {
      _items.removeWhere((item) => item.id == category.id);
    });
    return result;
  }
}
