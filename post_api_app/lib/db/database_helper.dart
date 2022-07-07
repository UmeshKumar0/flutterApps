// ignore_for_file: depend_on_referenced_packages, unnecessary_string_interpolations

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const todo = 'todo';

  static Future<Database> database() async {
    final dbPath = await getApplicationDocumentsDirectory();
    print("object");
    return await openDatabase(join(dbPath.path, "todo.db"),
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $todo(id TEXT PRIMARY KEY , title TEXT, description TEXT,date TEXT)");
      print("Table is created");
    }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> selectAll(String table) async {
    final db = await DBHelper.database();
    //With out Query
    return db.query(todo);

    // with Query
    print("Hello");
    //return db.rawQuery("SELECT * FROM $todo");
  }

  static Future insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future update(
    String tableName,
    String columnName,
    String value,
    String id,
  ) async {
    final db = await DBHelper.database();

    return db.update(
      tableName,
      {'$columnName': value},
      where: 'id = ? ',
      whereArgs: [id],
    );
  }

  static Future deleteById(
    String tableName,
    String columnName,
    String id,
  ) async {
    final db = await DBHelper.database();

    return db.delete(
      tableName,
      where: '$columnName = ?',
      whereArgs: [id],
    );
  }

  static Future deleteTable(String tableName) async {
    final db = await DBHelper.database();

    return db.rawQuery('DELETE FROM ${tableName}');
  }
}
