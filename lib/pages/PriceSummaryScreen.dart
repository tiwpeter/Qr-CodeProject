//สร้างหน้าคำนวณราคา (PriceCalculatorScreen)
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../db/database_helper.dart';
import '../models/todo.dart';
import '../models/sale.dart';

class PriceCalculatorScreen extends StatefulWidget {
  @override
  _PriceCalculatorScreenState createState() => _PriceCalculatorScreenState();
}

class _PriceCalculatorScreenState extends State<PriceCalculatorScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _quantityController = TextEditingController();
  
  ToDo? _selectedProduct;
  String _scanResult = 'ผลการสแกนจะปรากฏที่นี่';
  double _totalPrice = 0.0;

  Future<void> _scanBarcode() async {
    // Function to scan barcode and retrieve product
    final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
    final inputImage = InputImage.fromFilePath('your_image_path'); // Update with actual path

    try {
      final barcodes = await barcodeScanner.processImage(inputImage);
      if (barcodes.isNotEmpty) {
        final barcode = barcodes.first.displayValue;
        if (barcode != null) {
          final product = await _dbHelper.getTodoByBarcode(barcode);
          if (product != null) {
            setState(() {
              _selectedProduct = product;
              _scanResult = 'พบสินค้า: ${product.name} (${product.price} บาท)';
            });
          } else {
            setState(() {
              _scanResult = 'ไม่พบสินค้าด้วยบาร์โค้ดนี้';
              _selectedProduct = null;
            });
          }
        }
      } else {
        setState(() {
          _scanResult = 'ไม่พบบาร์โค้ดในภาพ';
          _selectedProduct = null;
        });
      }
    } catch (e) {
      setState(() {
        _scanResult = 'เกิดข้อผิดพลาด: $e';
        _selectedProduct = null;
      });
    } finally {
      await barcodeScanner.close();
    }
  }

  void _calculateTotal() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    if (_selectedProduct != null && quantity > 0) {
      setState(() {
        _totalPrice = _selectedProduct!.price * quantity;
      });
    }
  }

Future<void> _recordSale() async {
  if (_selectedProduct != null && _totalPrice > 0) {
    // Save sale to database
    await _dbHelper.insertSale(
      Sale(
        todoId: _selectedProduct!.id!,
        quantity: int.tryParse(_quantityController.text) ?? 0,
        total: _totalPrice,
        date: DateTime.now(), // ส่ง DateTime ตรงนี้
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('บันทึกการขายเรียบร้อย')),
    );
    Navigator.of(context).pop();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คำนวณราคา'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _scanBarcode,
              child: const Text('สแกนบาร์โค้ด'),
            ),
            const SizedBox(height: 20),
            Text(_scanResult),
            const SizedBox(height: 20),
            if (_selectedProduct != null) ...[
              Text('ชื่อสินค้า: ${_selectedProduct!.name}'),
              Text('ราคา: ${_selectedProduct!.price} บาท'),
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'จำนวนที่ต้องการขาย',
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => _calculateTotal(),
              ),
              const SizedBox(height: 20),
              Text('ราคารวม: ${_totalPrice.toStringAsFixed(2)} บาท'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _recordSale,
                child: const Text('บันทึกการขาย'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
