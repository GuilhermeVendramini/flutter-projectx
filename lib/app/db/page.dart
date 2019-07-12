import 'package:simpleslider/app/db/provider.dart';
import 'package:simpleslider/app/models/page.dart';

class DBPage {
  DBProvider dbProvider = new DBProvider();

  Future<List<PageModel>> get getAll async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = await db.query('page');
    return result.map((it) => PageModel.fromJson(it)).toList();
  }

  Future<int> insert(PageModel page) async {
    final db = await dbProvider.database;
    return db.insert('page', page.toJson());
  }

  Future<int> update(PageModel page) async {
    final db = await dbProvider.database;
    return db
        .update('page', page.toJson(), where: 'id = ?', whereArgs: [page.id]);
  }

  Future<int> delete(PageModel page) async {
    final db = await dbProvider.database;
    Future<int> result;
    result = db.delete('plugins', where: 'parent = ?', whereArgs: [page.id]);
    await result.then((_) {
      result = db.delete('page', where: 'id = ?', whereArgs: [page.id]);
    });
    return result;
  }
}
