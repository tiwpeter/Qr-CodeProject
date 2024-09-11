//เน้นที่การบันทึกการขายใหม่และการเลือกสินค้าจากรายการที่มีอยู่
//อัปเดตข้อมูลสินค้าและบันทึกการขายในฐานข้อมูล
import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/sale.dart';
import '../models/todo.dart';

class SalesScreenBarcode extends StatefulWidget {
  @override
  _SalesScreenBarcodeState createState() => _SalesScreenBarcodeState();
}

class _SalesScreenBarcodeState extends State<SalesScreenBarcode> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Sale> _sales = [];
  double _totalSales = 0.0;
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

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

  void _recordSale() async {
    final barcode = _barcodeController.text;
    final quantity = int.tryParse(_quantityController.text) ?? 0;

    if (barcode.isEmpty || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกข้อมูลให้ถูกต้อง')),
      );
      return;
    }

    try {
      final todo = await _dbHelper.getTodoByBarcode(barcode);
      if (todo == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่พบสินค้าด้วยบาร์โค้ดนี้')),
        );
        return;
      }

      final total = todo.price * quantity;
      await _dbHelper.recordSale(barcode, quantity, total);
      _loadSales();
      _barcodeController.clear();
      _quantityController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('บันทึกการขายตามบาร์โค้ด'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('ยอดขายรวม: ${_totalSales.toStringAsFixed(2)} บาท'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _barcodeController,
                  decoration: InputDecoration(labelText: 'บาร์โค้ดสินค้า'),
                ),
                TextField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'จำนวน'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: _recordSale,
                  child: Text('บันทึกการขาย'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _sales.length,
              itemBuilder: (context, index) {
                final sale = _sales[index];
                return FutureBuilder<ToDo?>(
                  future: _dbHelper.getTodoByBarcode(sale.todoId.toString()), // Assuming todoId is a valid barcode
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      final todo = snapshot.data;
                      if (todo != null) {
                        return ListTile(
                          title: Text(todo.name ?? 'ไม่มีชื่อ'),
                          subtitle: Text('จำนวน: ${sale.quantity} ราคา: ${sale.total} บาท'),
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