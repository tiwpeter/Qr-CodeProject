import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../models/barcode_result.dart';

class BarcodeService {
  final _barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  Future<BarcodeResult?> scanBarcodeFromImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final barcodes = await _barcodeScanner.processImage(inputImage);

      if (barcodes.isNotEmpty) {
        return BarcodeResult(value: barcodes.first.displayValue);
      }
      return null;
    } catch (e) {
      print("Error scanning barcode: $e");
      return null;
    }
  }

  Future<void> dispose() async {
    await _barcodeScanner.close();
  }
}
