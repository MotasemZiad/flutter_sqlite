import 'package:local_storage/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static DatabaseHelper databaseHelper = DatabaseHelper._();
  static final String databaseName = 'tasksDB.db';
  static final String tableName = 'tasks';
  static final String taskIDColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String taskIsCompleteColumnName = 'isComplete';

  Database database;
  Future<Database> initDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  Future<Database> createDatabase() async {
    try {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, databaseName);

      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''CREATE TABLE $tableName(
            $taskIDColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $taskNameColumnName TEXT NUT NULL,
            $taskIsCompleteColumnName INTEGER
          );''');
        },
      );
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTask(Task task) async {
    database = await initDatabase();
    int x = await database.insert(tableName, task.toJson());
    print(x);
  }

  Future<List<Map>> selectAllTasks() async {
    database = await initDatabase();
    List<Map> result = await database.query(tableName);
    return result;
  }

  Future<List<Map>> selectCompleteTask() async {
    database = await initDatabase();
    List<Map> result = await database
        .query(tableName, where: '$taskIsCompleteColumnName=?', whereArgs: [1]);
    return result;
  }

  Future<List<Map>> selectInCompleteTask() async {
    database = await initDatabase();
    List<Map> result = await database
        .query(tableName, where: '$taskIsCompleteColumnName=?', whereArgs: [0]);
    return result;
  }

  updateTask(Task task) async {
    database = await initDatabase();
    int x = await database.update(tableName, task.toJson(),
        where: '$taskNameColumnName =?', whereArgs: [task.taskName]);
    print(x);
  }

  deleteTask(Task task) async {
    database = await initDatabase();
    int x = await database.delete(tableName,
        where: '$taskNameColumnName =?', whereArgs: [task.taskName]);
    print(x);
  }
}
