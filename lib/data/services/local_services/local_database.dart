import 'package:sqflite/sqflite.dart';
import 'package:todo/data/models/task_model.dart';

class LocalDataBase {
  final String _tableName = 'firstTask';
  String _databaseName = 'tasks.db';
  Database? _db;

  initDatabase() async {
    try {
      _databaseName = await getDatabasesPath() + _databaseName;
      _db = await openDatabase(_databaseName, version: 1, onCreate: _onCreate);
    } catch (error) {
      rethrow;
    }
  }

  _onCreate(Database db, int version) async {
    return
    await db.execute(
        "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT, date STRING, startTime STRING, endTime STRING, remind INTEGER, repeat STRING, color INTEGER, isCompleted INTEGER )");
  }

  Future<int?> insertToDB({required TaskModel task}) async {
    try {
      return await _db?.insert(
        _tableName,
        task.toMap(),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>?> readFromDB() async {
    try {
      return await _db?.query(_tableName);
    } catch (error) {
      rethrow;
    }
  }
  Future<int?> updateDB({required TaskModel task}) async {
    try {
      return await _db?.update(
        _tableName,
        task.toMap(),
        where: 'Id = ?',
        whereArgs: [task.id],
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<int?> deleteFromDB({required int taskId}) async {
    try {
      return await _db?.delete(
        _tableName,
        where: 'Id = ?',
        whereArgs: [taskId],
      );
    } catch (error) {
      rethrow;
    }
  }

}
