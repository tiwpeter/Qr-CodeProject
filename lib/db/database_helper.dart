import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo.dart';
import '../models/sale.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<void> _deleteDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'todo_database_new.db');
    await deleteDatabase(dbPath);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final db = await openDatabase(
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
        if (oldVersion < 5) {
          db.execute(
            'CREATE TABLE IF NOT EXISTS sales(id INTEGER PRIMARY KEY AUTOINCREMENT, todoId INTEGER, quantity INTEGER, total REAL, date TEXT, FOREIGN KEY(todoId) REFERENCES todos(id))',
          );
        }
      },
      version: 5,
    );

    // Check if tables exist
    final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    print('Existing tables: ${tables.map((e) => e['name']).toList()}');
    return db;
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
  Future<void> _ensureSalesTableExists(Database db) async {
    final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    final salesTableExists = tables.any((table) => table['name'] == 'sales');

    if (!salesTableExists) {
      await db.execute(
        'CREATE TABLE sales(id INTEGER PRIMARY KEY AUTOINCREMENT, todoId INTEGER, quantity INTEGER, total REAL, date TEXT, FOREIGN KEY(todoId) REFERENCES todos(id))',
      );
    }
  }

  Future<void> insertSale(Sale sale) async {
    final db = await database;

    // Ensure the sales table exists before inserting
    await _ensureSalesTableExists(db);

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

  Future<ToDo?> getTodoByBarcode(String barcode) async {
    final db = await database;
    final maps = await db.query(
      'todos',
      where: 'barcode = ?',
      whereArgs: [barcode],
    );
    if (maps.isNotEmpty) {
      return ToDo.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Sale>> getSalesByBarcode(String barcode) async {
    final db = await database;

    // ค้นหา `ToDo` ที่ตรงกับบาร์โค้ด
    final todoMaps = await db.query(
      'todos',
      where: 'barcode = ?',
      whereArgs: [barcode],
    );

    if (todoMaps.isEmpty) {
      // ถ้าไม่พบ `ToDo` ที่มีบาร์โค้ดนี้
      return [];
    }

    // ดึง ID ของ `ToDo`
    final todoId = todoMaps.first['id'] as int;

    // ค้นหาข้อมูล `Sale` ที่เกี่ยวข้อง
    final saleMaps = await db.query(
      'sales',
      where: 'todoId = ?',
      whereArgs: [todoId],
    );

    return List.generate(saleMaps.length, (i) {
      return Sale.fromMap(saleMaps[i]);
    });
  }

  Future<void> recordSale(String barcode, int quantity, double total) async {
    final db = await database;

    // Ensure the sales table exists before inserting
    await _ensureSalesTableExists(db);

    // ค้นหา `ToDo` ที่ตรงกับบาร์โค้ด
    final todoMaps = await db.query(
      'todos',
      where: 'barcode = ?',
      whereArgs: [barcode],
    );

    if (todoMaps.isEmpty) {
      throw Exception('ToDo with barcode $barcode not found');
    }

    // ดึง ID ของ `ToDo`
    final todoId = todoMaps.first['id'] as int;

    // บันทึกข้อมูล `Sale`
    await db.insert(
      'sales',
      {
        'todoId': todoId,
        'quantity': quantity,
        'total': total,
        'date': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Sale>> getSalesInDateRange(DateTime startDate, DateTime endDate) async {
    final db = await database;

    // แปลงวันเป็นรูปแบบ ISO String
    final start = startDate.toIso8601String();
    final end = endDate.toIso8601String();

    final saleMaps = await db.query(
      'sales',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [start, end],
    );

    return List.generate(saleMaps.length, (i) {
      return Sale.fromMap(saleMaps[i]);
    });
  }

  Future<void> deleteSale(int id) async {
    final db = await database;
    await db.delete(
      'sales',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
