import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/barcode_result.dart';
import '../services/barcode_service.dart';
import '../views/result_view.dart'; // ต้อง import หน้า ResultView ด้วย

class BarcodeViewModel extends ChangeNotifier {
  final BarcodeService _service = BarcodeService();
  BarcodeResult? _result;
  bool _isLoading = false;
  File? _selectedImage;

  BarcodeResult? get result => _result;
  bool get isLoading => _isLoading;
  File? get selectedImage => _selectedImage;

  Future<void> scanFromGallery(File imageFile) async {
    _isLoading = true;
    _selectedImage = imageFile;
    notifyListeners();

    _result = await _service.scanBarcodeFromImage(imageFile);

    _isLoading = false;
    notifyListeners();
  }

  /// ✅ แบบนำทางตรงไปหน้า ResultView
  Future<void> pickImageAndScan(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await scanFromGallery(File(pickedFile.path));

      if (_result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultView(result: _result?.value ?? 'ไม่พบข้อมูล'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
