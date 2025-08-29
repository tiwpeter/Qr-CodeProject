import 'package:flutter/material.dart';
import 'package:poject_qr/db/db_helper.dart';

class DatabaseViewModel extends ChangeNotifier {
  final _dbService = DBHelper();

  Future<void> resetAndRecreateDB() async {
    await _dbService.resetDatabase(); // ลบไฟล์เก่า
    await _dbService.database; // สร้างใหม่พร้อมตาราง
    notifyListeners();
  }
}
