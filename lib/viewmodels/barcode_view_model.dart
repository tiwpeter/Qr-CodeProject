import 'dart:io';
import 'package:flutter/material.dart';
import '../models/barcode_result.dart';
import '../services/barcode_service.dart';

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

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
