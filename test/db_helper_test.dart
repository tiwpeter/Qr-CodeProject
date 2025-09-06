import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:poject_qr/models/ProductModel.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  sqfliteFfiInit(); // สำหรับ FFI (Windows/Linux/Mac)
  databaseFactory = databaseFactoryFfi;

  late String dbPath;
  late Database db;

  setUpAll(() async {
    dbPath = join(await databaseFactory.getDatabasesPath(), 'barcode.db');

    // เปิด database
    db = await databaseFactory.openDatabase(dbPath);

    // สร้าง table ถ้ายังไม่มี
    await db.execute('''
      CREATE TABLE IF NOT EXISTS product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        barcode TEXT NOT NULL,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT
      )
    ''');
  });

  tearDownAll(() async {
    await db.close();
  });

  test('Fetch all products dynamically', () async {
    final List<Map<String, dynamic>> maps = await db.query('product');

    if (maps.isEmpty) {
      print('No products found in database.');
    } else {
      final List<ProductModel> products = List.generate(maps.length, (i) {
        return ProductModel.fromMap(maps[i]);
      });

      // แสดงผลข้อมูล
      for (var p in products) {
        print(
            'ID: ${p.id}, Barcode: ${p.barcode}, Name: ${p.name}, Price: ${p.price}, Image: ${p.imagePath}');
      }

      expect(products.isNotEmpty, true); // ตรวจสอบว่ามีข้อมูลจริง
    }
  });
}
