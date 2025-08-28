import 'package:poject_qr/models/ProductModel.dart';
import 'package:poject_qr/models/barcode_result.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'barcode.db');
    return await openDatabase(
      path,
      version: 2, // เปลี่ยนเวอร์ชันเมื่อมีการแก้ schema
      onCreate: (db, version) async {
        // สร้างตาราง barcodes
        await db.execute('''
        CREATE TABLE IF NOT EXISTS barcodes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          value TEXT,
          imagePath TEXT
        )
      ''');

        // สร้างตาราง product
        await db.execute('''
        CREATE TABLE IF NOT EXISTS product(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          barcode TEXT UNIQUE,
          name TEXT,
          price REAL
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // ตรวจสอบว่า product table มีอยู่หรือยัง ถ้ายังไม่มี ให้สร้าง
        await db.execute('''
        CREATE TABLE IF NOT EXISTS product(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          barcode TEXT UNIQUE,
          name TEXT,
          price REAL
        )
      ''');
      },
    );
  }

  Future<int> insertBarcode(BarcodeModel barcode) async {
    final db = await database;
    return await db.insert('barcodes', barcode.toMap());
  }

  Future<List<BarcodeModel>> getAllBarcodes() async {
    final db = await database;
    final maps = await db.query('barcodes');
    return List.generate(maps.length, (i) => BarcodeModel.fromMap(maps[i]));
  }

  Future<int> insertProduct(ProductModel product) async {
    final db = await database;
    return await db.insert('product', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ProductModel>> getAllProducts() async {
    final db = await database;
    final maps = await db.query('product');
    return maps.map((map) => ProductModel.fromMap(map)).toList();
  }
}
