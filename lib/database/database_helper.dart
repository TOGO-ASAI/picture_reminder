import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        reminder_date TEXT,
        is_active BOOLEAN,
        created_at TEXT,
        updated_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        caption TEXT,
        image_path TEXT,
        taken_at TEXT,
        reminder_id INTEGER,
        FOREIGN KEY (reminder_id) REFERENCES reminders(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<int> insertReminder(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('reminders', row);
  }

  Future<List<Map<String, dynamic>>> queryAllReminders() async {
    Database db = await instance.database;
    return await db.query('reminders');
  }

  Future<int> updateReminder(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update('reminders', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteReminder(int id) async {
    Database db = await instance.database;
    return await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertImage(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('images', row);
  }

  Future<List<Map<String, dynamic>>> queryImagesByReminder(int reminderId) async {
    Database db = await instance.database;
    return await db.query('images', where: 'reminder_id = ?', whereArgs: [reminderId]);
  }

  Future<int> updateImage(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update('images', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteImage(int id) async {
    Database db = await instance.database;
    return await db.delete('images', where: 'id = ?', whereArgs: [id]);
  }
}
