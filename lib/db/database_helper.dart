import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  
Future<Database> _initDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'todo_database_new.db'), // เปลี่ยนชื่อฐานข้อมูล
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, isDone INTEGER, barcode TEXT, imagePath TEXT)',
      );
    },
    onUpgrade: (db, oldVersion, newVersion) {
      if (oldVersion < 2) {
        db.execute(
          'ALTER TABLE todos ADD COLUMN imagePath TEXT',
        );
      }
    },
    version: 2, // เพิ่มเวอร์ชันที่เพิ่มขึ้นจาก 1 เป็น 2
  );
}

  Future<void> insertToDo(ToDo todo) async {
    final db = await database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ToDo>> todos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return ToDo.fromMap(maps[i]);
    });
  }

  Future<void> updateToDo(ToDo todo) async {
    final db = await database;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteToDo(int id) async {
    final db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
