import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo.dart';
import '../models/sale.dart';

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
      join(await getDatabasesPath(), 'todo_database_new.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, isDone INTEGER, barcode TEXT, imagePath TEXT, name TEXT, price REAL, quantity INTEGER)',
        );
        db.execute(
          'CREATE TABLE sales(id INTEGER PRIMARY KEY AUTOINCREMENT, todoId INTEGER, quantity INTEGER, total REAL, date TEXT, FOREIGN KEY(todoId) REFERENCES todos(id))',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute('ALTER TABLE todos ADD COLUMN imagePath TEXT');
        }
        if (oldVersion < 3) {
          db.execute('ALTER TABLE todos ADD COLUMN name TEXT');
          db.execute('ALTER TABLE todos ADD COLUMN price REAL');
        }
        if (oldVersion < 4) {
          db.execute('ALTER TABLE todos ADD COLUMN quantity INTEGER');
        }
        // Add new schema changes for future versions if needed
      },
      version: 5, // Increment version number for schema changes
    );
  }

  // ToDo Methods
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

  // Sale Methods
  Future<void> insertSale(Sale sale) async {
    final db = await database;
    await db.insert(
      'sales',
      sale.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Sale>> sales() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sales');
    return List.generate(maps.length, (i) {
      return Sale.fromMap(maps[i]);
    });
  }
  
  Future<double> getTotalSales() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT SUM(total) as totalSales FROM sales');
    return result.first['totalSales']?.toDouble() ?? 0.0;
  }

// 
Future<List<ToDo>> getAllTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return ToDo.fromMap(maps[i]);
    });
  }

  Future<double> calculateTotalPrice() async {
    final todos = await getAllTodos();
    double totalPrice = 0.0;

    for (var todo in todos) {
      totalPrice += todo.price * todo.quantity;
    }

    return totalPrice;
  }






}
