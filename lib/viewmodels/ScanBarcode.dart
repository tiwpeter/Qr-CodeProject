import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poject_qr/views/addproducts.dart';
import '../services/barcode_service.dart';

class ScanBarcodeViewModel extends ChangeNotifier {
  final BarcodeService _barcodeService = BarcodeService();

  bool isLoading = false;
  String? barcode;

  Future<void> scanFromGallery(BuildContext context) async {
    await _pickImageAndScan(context, ImageSource.gallery);
  }

  Future<void> scanFromCamera(BuildContext context) async {
    await _pickImageAndScan(context, ImageSource.camera);
  }

  Future<void> _pickImageAndScan(
      BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) return;

    isLoading = true;
    notifyListeners();

    final result =
        await _barcodeService.scanBarcodeFromImage(File(pickedFile.path));
    isLoading = false;
    notifyListeners();

    if (result != null && result.value != null) {
      barcode = result.value;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddProductView(barcode: barcode),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่พบ Barcode ในภาพ')),
      );
    }
  }
}
