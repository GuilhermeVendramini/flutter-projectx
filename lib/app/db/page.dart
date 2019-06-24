import 'package:projetcx/app/db/provider.dart';
import 'package:projetcx/app/models/page.dart';

class DBPage {
  DBProvider dbProvider = new DBProvider();

  Future<List<PageModel>> get getAll async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = await db.query('page');
    return result.map((it) => PageModel.fromJson(it)).toList();
  }

  Future<int> insertItem(PageModel page) async {
    final db = await dbProvider.database;
    return db.insert('page', page.toJson());
  }
}
