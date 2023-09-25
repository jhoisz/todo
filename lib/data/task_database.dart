import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../domain/entities/task.dart';

class TaskDatabase {
  static const String _tableName = 'taskTable';
  static const String _id = 'id';
  static const String _title = 'title';
  static const String _description = 'description';
  static const String _priority = 'priority';

  static const String createTableSQL =
      'CREATE TABLE $_tableName($_id INTEGER NOT NULL PRIMARY KEY,$_title TEXT,$_description TEXT, $_priority TEXT)';

  Future<Database> _getDatabase() async {
    final String path = join(await getDatabasesPath(), 'tasks.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(createTableSQL);
      },
      version: 1,
    );
  }

  Future<void> save(Task task) async {
    print('SAVE');

    Map<String, dynamic> taskMap = task.toMap();

    final Database database = await _getDatabase();

    if (task.id == null) {
      print('CREATING ${task.toString()}');
      await database.insert(_tableName, taskMap);
    } else {
      print('UPDATING ${task.toString()}');
      await database.update(
        _tableName,
        taskMap,
        where: '$_id = ?',
        whereArgs: [task.id],
      );
    }
  }

  Future<void> delete(Task task) async {
    print('DELETE');

    final Database database = await _getDatabase();

    await database.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [task.id],
    );
  }

  Future<List<Task>> findAll() async {
    print('FIND ALL');

    final Database database = await _getDatabase();

    final List<Map<String, dynamic>> result = await database.query(_tableName);

    print(result);

    return result.map((item) => Task.fromMap(item)).toList();
  }
}
