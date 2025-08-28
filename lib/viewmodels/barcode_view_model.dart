import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poject_qr/services/barcode_service.dart';
import 'package:poject_qr/views/result_view.dart';

import '../db/db_helper.dart';
import '../models/barcode_result.dart';

class BarcodeViewModel extends ChangeNotifier {
  final BarcodeService _service = BarcodeService();
  final DBHelper _dbHelper = DBHelper();
  BarcodeResult? _result;
  bool _isLoading = false;
  File? _selectedImage;

  BarcodeResult? get result => _result;
  bool get isLoading => _isLoading;
  File? get selectedImage => _selectedImage;

  // ฟังก์ชันสแกนจากไฟล์
  Future<void> scanFromGallery(File imageFile) async {
    _isLoading = true;
    _selectedImage = imageFile;
    notifyListeners();

    _result = await _service.scanBarcodeFromImage(imageFile);

    _isLoading = false;
    notifyListeners();
  }

  // ฟังก์ชันดึงประวัติ
  Future<List<BarcodeModel>> getHistory() async {
    return await _dbHelper.getAllBarcodes();
  }

  // ฟังก์ชันค้นหาสินค้าโดยใช้ barcode
  Future<Map<String, dynamic>?> searchProduct(String barcode) async {
    // สมมติว่าเรามี service หรือ DB query
    // ตัวอย่าง mock data:
    Map<String, Map<String, dynamic>> products = {
      'ABC-abc-1234': {'name': 'สินค้า A', 'price': 100},
      '789012': {'name': 'สินค้า B', 'price': 200},
    };

    return products[barcode];
  }

  // ✅ รวมฟังก์ชัน pick image + scan + search + navigate
  Future<void> pickImageScanAndSearch(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    await scanFromGallery(File(pickedFile.path));

    if (_result != null && _result!.value != null) {
      // เรียกค้นหาสินค้า
      final product = await searchProduct(_result!.value!);

      if (product != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultView(product: product),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ไม่พบสินค้าในฐานข้อมูล')),
        );
      }
    }
  }

  Future<void> pickImageScan(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    await scanFromGallery(File(pickedFile.path));
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
/*

  // ฟังก์ชันเลือกภาพจาก Gallery and scan
  Future<void> pickImageAndScan(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await scanFromGallery(File(pickedFile.path));
    }
  }

 */
