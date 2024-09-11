//หน้าจอที่ให้ผู้ใช้สามารถนำสินค้าออกจากคลังโดยใช้ราคาและจำนวนที่เลือก โดยใช้บาร์โค้ดในการค้นหาสินค้า และสามารถบันทึกการขายได้เมื่อกดปุ่ม "Sell
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../db/database_helper.dart';
import '../models/sale.dart';
import '../models/todo.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  ToDo? _selectedToDo;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _scanBarcode() async {
    // ใช้ ImagePicker เลือกรูปภาพจากแกลเลอรี
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ไม่เลือกภาพ')),
      );
      return;
    }

    final inputImage = InputImage.fromFilePath(pickedFile.path);
    final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

    try {
      final barcodes = await barcodeScanner.processImage(inputImage);
      if (barcodes.isNotEmpty) {
        final barcode = barcodes.first.displayValue;
        if (barcode != null) {
          final product = await _dbHelper.getTodoByBarcode(barcode);
          if (product != null) {
            setState(() {
              _selectedToDo = product;
              _barcodeController.text = barcode;
              _totalPrice = product.price * (int.tryParse(_quantityController.text) ?? 0);
            });
          } else {
            setState(() {
              _selectedToDo = null;
              _totalPrice = 0.0;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('ไม่พบสินค้าด้วยบาร์โค้ดนี้')),
              );
            });
          }
        }
      } else {
        setState(() {
          _selectedToDo = null;
          _totalPrice = 0.0;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('ไม่พบบาร์โค้ดในภาพ')),
          );
        });
      }
    } catch (e) {
      setState(() {
        _selectedToDo = null;
        _totalPrice = 0.0;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
        );
      });
    } finally {
      await barcodeScanner.close();
    }
  }

  Future<void> _recordSale() async {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    if (_selectedToDo == null || quantity <= 0 || quantity > (_selectedToDo?.quantity ?? 0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('จำนวนที่เลือกไม่ถูกต้อง')),
      );
      return;
    }

    final total = _selectedToDo!.price * quantity;
    final sale = Sale(
      todoId: _selectedToDo!.id!,
      quantity: quantity,
      total: total,
      date: DateTime.now(),
    );

    await _dbHelper.insertSale(sale);
    await _dbHelper.updateToDo(ToDo(
      id: _selectedToDo!.id,
      task: _selectedToDo!.task,
      isDone: _selectedToDo!.isDone,
      barcode: _selectedToDo!.barcode,
      imagePath: _selectedToDo!.imagePath,
      name: _selectedToDo!.name,
      price: _selectedToDo!.price,
      quantity: _selectedToDo!.quantity - quantity,
    ));

    _barcodeController.clear();
    _quantityController.clear();
    setState(() {
      _selectedToDo = null;
      _totalPrice = 0.0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('บันทึกการขายเรียบร้อย')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _barcodeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Barcode',
              ),
              readOnly: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _scanBarcode,
              child: const Text('Scan Barcode'),
            ),
            const SizedBox(height: 20),
            if (_selectedToDo != null) ...[
              Text('สินค้า: ${_selectedToDo!.name}'),
              Text('ราคา: ${_selectedToDo!.price} บาท'),
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quantity',
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  final quantity = int.tryParse(_quantityController.text) ?? 0;
                  setState(() {
                    _totalPrice = _selectedToDo!.price * quantity;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('ราคารวม: ${_totalPrice.toStringAsFixed(2)} บาท'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _recordSale,
                child: const Text('Sell'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
