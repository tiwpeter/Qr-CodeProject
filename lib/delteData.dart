import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ทำให้ async ใช้งานได้ใน main()
  await deleteDatabaseFile(); // ลบฐานข้อมูลเมื่อเริ่มแอป
  runApp(MyApp());
}

Future<void> deleteDatabaseFile() async {
  String path = join(await getDatabasesPath(), 'your_database_name.db');
  await deleteDatabase(path);
  print('Database deleted: $path');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("SQLite Delete Example")),
        body: Center(
          child: Text("Database deleted successfully!"),
        ),
      ),
    );
  }
}
