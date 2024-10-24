import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../db/database_helper.dart';
import '../models/todo.dart';
import '../pages/Addstock.dart';

class BarcodeScannerScreen extends StatefulWidget {
  final String result; // Parameter to receive initial barcode result

  BarcodeScannerScreen({required this.result}); // Constructor

  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final ImagePicker _picker = ImagePicker();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  String _scanResult = 'ผลการสแกนจะปรากฏที่นี่';
  File? _image2;
  String? _barcode;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scanResult = widget.result;
  }

  Future<void> _pickSecondImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image2 = File(pickedFile.path);
      });
      if (_image2 != null) {
        await _scanBarcodeFromImage(_image2!);
      }
    }
  }

  Future<void> _scanBarcodeFromImage(File image) async {
    setState(() {
      _isLoading = true;
    });

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
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveToDoItem() async {
    if (_barcode == null) return;

    // นำทางไปยังหน้าจอ AddStock และส่งค่ารหัส QR Code
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddStock(result: _barcode!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สแกนบาร์โค้ด/QR Code'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickSecondImage,
              child: const Text('เลือกรูปภาพที่สอง'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) Center(child: CircularProgressIndicator()),
            if (_image2 != null && !_isLoading)
              Image.file(_image2!), // Show the selected image
            const SizedBox(height: 20),
            // Display the scan result from the second image
            Text(
              'ผลการสแกนจากรูปภาพที่สอง: $_scanResult',
              style: TextStyle(fontSize: 16),
            ),
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
