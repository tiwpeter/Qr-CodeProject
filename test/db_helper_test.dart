import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:poject_qr/db/db_helper.dart';
import 'dart:io';
import 'package:path/path.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  test('Add imagePath column in test', () async {
    final dbPath = await databaseFactory.getDatabasesPath();
    final path = join(dbPath, 'barcode.db');

    // ลบ DB เดิม
    if (await File(path).exists()) {
      await deleteDatabase(path);
    }

    final dbHelper = DBHelper();
    final db = await dbHelper.database;

    // ตรวจสอบ column ก่อน
    var hasImagePath = await dbHelper.hasColumn('product', 'imagePath');
    print('Before ALTER: $hasImagePath'); // จะเป็น false

    // เพิ่ม column ด้วย ALTER TABLE ถ้ายังไม่มี
    if (!hasImagePath) {
      await db.execute('ALTER TABLE product ADD COLUMN imagePath TEXT');
      print('imagePath column added via test ALTER TABLE.');
    }

    // ตรวจสอบ column อีกครั้ง
    hasImagePath = await dbHelper.hasColumn('product', 'imagePath');
    print('After ALTER: $hasImagePath'); // จะเป็น true

    expect(hasImagePath, true);
  });
}
