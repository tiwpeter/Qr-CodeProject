import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/sale.dart';
import '../models/todo.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Sale> _sales = [];
  double _totalSales = 0.0;

  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  void _loadSales() async {
    final sales = await _dbHelper.sales();
    final totalSales = await _dbHelper.getTotalSales();
    setState(() {
      _sales = sales;
      _totalSales = totalSales;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลการขาย'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'ยอดขายรวม: ${_totalSales.toStringAsFixed(2)} บาท',
              style: Theme.of(context).textTheme.headlineMedium, // Changed from headline6 to headlineMedium
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _sales.length,
              itemBuilder: (context, index) {
                final sale = _sales[index];
                return FutureBuilder<ToDo?>(
                  future: _dbHelper.getTodoById(sale.todoId), // Fetch ToDo by ID
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      final todo = snapshot.data;
                      if (todo != null) {
                        return ListTile(
                          title: Text(todo.name ?? 'ไม่มีชื่อ'),
                          subtitle: Text(
                              'จำนวน: ${sale.quantity} ราคา: ${sale.total} บาท\nวันที่: ${sale.date}'),
                        );
                      } else {
                        return ListTile(title: Text('ไม่พบข้อมูล'));
                      }
                    } else {
                      return ListTile(title: Text('ไม่พบข้อมูล'));
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
