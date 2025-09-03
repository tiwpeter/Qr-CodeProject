import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/barcode_service.dart';

class ProductImage extends ChangeNotifier {
  final BarcodeService _service = BarcodeService();
  File? _productImage; // ✅ รูปสินค้า

  // ✅ เพิ่ม getter สำหรับ _productImage
  File? get productImage => _productImage;

  /// เลือกรูปสินค้า
  Future<void> pickProductImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _productImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  /// ปิด resource ของ Service
  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
