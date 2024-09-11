import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';
import '../db/database_helper.dart';
import '../models/todo.dart';

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final ImagePicker _picker = ImagePicker();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String _scanResult = 'ผลการสแกนจะปรากฏที่นี่';
  File? _image;
  String? _barcode;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _scanBarcodeFromImage(_image!);
    }
  }

  Future<void> _scanBarcodeFromImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

    try {
      final barcodes = await barcodeScanner.processImage(inputImage);
      if (barcodes.isNotEmpty) {
        final barcode = barcodes.first.displayValue;
        setState(() {
          _scanResult = barcode ?? 'ไม่พบข้อมูลบาร์โค้ด';
          _barcode = barcode;
        });
      } else {
        setState(() {
          _scanResult = 'ไม่พบบาร์โค้ดในภาพ';
          _barcode = null;
        });
      }
    } catch (e) {
      setState(() {
        _scanResult = 'เกิดข้อผิดพลาด: $e';
        _barcode = null;
      });
    } finally {
      await barcodeScanner.close();
    }
  }

  Future<void> _saveToDoItem() async {
    if (_barcode == null) return;

    final todo = ToDo(
      task: _nameController.text.isNotEmpty ? _nameController.text : 'Product with Barcode $_barcode',
      barcode: _barcode!,
      imagePath: _image?.path,
      name: _nameController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      quantity: int.tryParse(_quantityController.text) ?? 1,
    );
    await _dbHelper.insertToDo(todo);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สแกนบาร์โค้ด/QR Code'),
      ),
      body: SingleChildScrollView( // Wrap content in a scroll view
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('เลือกรูปภาพจากคลังรูปภาพ'),
            ),
            const SizedBox(height: 20),
            _image != null ? Image.file(_image!) : const SizedBox.shrink(),
            const SizedBox(height: 20),
            Text(_scanResult),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ชื่อสินค้า',
              ),
              maxLines: 1, // Single line input
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ราคา',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'จำนวนสินค้า',
              ),
              keyboardType: TextInputType.number,
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            if (_barcode != null)
              ElevatedButton(
                onPressed: _saveToDoItem,
                child: const Text('บันทึกข้อมูล'),
              ),
          ],
        ),
      ),
    );
  }
}
