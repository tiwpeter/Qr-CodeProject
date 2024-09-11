import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/todo.dart';

class PriceSummaryScreen extends StatefulWidget {
  @override
  _PriceSummaryScreenState createState() => _PriceSummaryScreenState();
}

class _PriceSummaryScreenState extends State<PriceSummaryScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<double> _fetchTotalPrice() async {
    return await _dbHelper.calculateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ราคาสุทธิทั้งหมด'),
      ),
      body: FutureBuilder<double>(
        future: _fetchTotalPrice(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ราคาสุทธิทั้งหมด: ${snapshot.data!.toStringAsFixed(2)} บาท',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('ไม่พบข้อมูล'));
          }
        },
      ),
    );
  }
}
