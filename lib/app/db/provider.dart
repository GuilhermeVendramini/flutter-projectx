import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  get dbPath async {
    String documentsDirectory = await _localPath;
    return p.join(documentsDirectory, "projectx.db");
  }

  Future<bool> dbExists() async {
    return File(await dbPath).exists();
  }

  initDB() async {
    String path = await dbPath;
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE page ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "color INTEGER,"
          "weight INTEGER"
          ")");
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  closeDB() {
    if (_database != null) {
      _database.close();
    }
  }
}
