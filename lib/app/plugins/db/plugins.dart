import 'package:projetcx/app/db/provider.dart';
import 'package:projetcx/app/plugins/models/plugin_data.dart';

class DBPlugins {
  DBProvider dbProvider = new DBProvider();

  Future<List<PluginDataModel>> get getAll async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = await db.query('plugins');
    return result.map((it) => PluginDataModel.fromJson(it)).toList();
  }

  Future<int> insert(PluginDataModel plugin) async {
    final db = await dbProvider.database;
    return db.insert('plugins', plugin.toJson());
  }

  Future<int> update(PluginDataModel plugin) async {
    final db = await dbProvider.database;
    return db.update('plugins', plugin.toJson(),
        where: 'id = ?', whereArgs: [plugin.id]);
  }

  Future<int> delete(PluginDataModel plugin) async {
    final db = await dbProvider.database;
    return db.delete('plugins', where: 'id = ?', whereArgs: [plugin.id]);
  }

  Future<int> deleteByParent(int parent) async {
    final db = await dbProvider.database;
    return db.delete('plugins', where: 'parent = ?', whereArgs: [parent]);
  }
}
