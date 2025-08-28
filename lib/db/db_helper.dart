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
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE barcodes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            value TEXT,
            imagePath TEXT
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
}
