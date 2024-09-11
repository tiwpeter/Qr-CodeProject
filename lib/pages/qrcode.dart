import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';

void main() => runApp(const Qrcode());

class Qrcode extends StatelessWidget {
  const Qrcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Scan Barcode from Image')),
        body: const BarcodeScannerFromImageScreen(),
      ),
    );
  }
}

class BarcodeScannerFromImageScreen extends StatefulWidget {
  const BarcodeScannerFromImageScreen({Key? key}) : super(key: key);

  @override
  _BarcodeScannerFromImageScreenState createState() => _BarcodeScannerFromImageScreenState();
}

class _BarcodeScannerFromImageScreenState extends State<BarcodeScannerFromImageScreen> {
  final ImagePicker _picker = ImagePicker();
  String _scanResult = 'ผลการสแกนจะปรากฏที่นี่';
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _scanBarcodeFromImage(_image!);
    }
  }

  Future<void> _scanBarcodeFromImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

    try {
      final barcodes = await barcodeScanner.processImage(inputImage);
      setState(() {
        _scanResult = barcodes.isNotEmpty
            ? barcodes.first.displayValue ?? 'ไม่พบข้อมูลบาร์โค้ด'
            : 'ไม่พบบาร์โค้ดในภาพ';
      });
    } catch (e) {
      setState(() {
        _scanResult = 'เกิดข้อผิดพลาด: $e';
      });
    } finally {
      await barcodeScanner.close(); // Ensure resource is closed properly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
        ],
      ),
    );
  }
}
