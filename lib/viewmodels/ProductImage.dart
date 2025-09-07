import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/barcode_service.dart';

class ProductImage extends ChangeNotifier {
  final BarcodeService _service = BarcodeService();
  File? _productImage; // รูปสินค้า

  File? get productImage => _productImage;

  /// เลือกรูปสินค้า พร้อมระบุ source (camera/gallery)
  Future<void> pickProductImage(
      [ImageSource source = ImageSource.gallery]) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

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
