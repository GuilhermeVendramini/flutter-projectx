import 'package:projetcx/app/db/provider.dart';
import 'package:projetcx/app/models/category.dart';

class DBPage {
  DBProvider dbProvider = new DBProvider();

  Future<List<CategoryModel>> get getAll async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = await db.query('category');
    return result.map((it) => CategoryModel.fromJson(it)).toList();
  }

  Future<int> insert(CategoryModel category) async {
    final db = await dbProvider.database;
    return db.insert('category', category.toJson());
  }

  Future<int> update(CategoryModel category) async {
    final db = await dbProvider.database;
    return db
        .update('category', category.toJson(), where: 'id = ?', whereArgs: [category.id]);
  }

  Future<int> delete(CategoryModel category) async {
    final db = await dbProvider.database;
    Future<int> result;
    result = db.delete('category', where: 'parent = ?', whereArgs: [category.id]);
    await result.then((_) {
      result = db.delete('category', where: 'id = ?', whereArgs: [category.id]);
    });
    return result;
  }
}
