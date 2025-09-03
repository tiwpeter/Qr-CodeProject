import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:poject_qr/db/db_helper.dart';
import 'package:poject_qr/models/ProductModel.dart';
import '../views/keep/PaymentReceipt.dart';

class ScanPaymentViewModel extends ChangeNotifier {
  bool isLoading = false;

  Future<void> scanFromCamera(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    // TODO: ใช้กล้องสแกน QR Code
    // สามารถใช้ package เช่น `mobile_scanner` หรือ `qr_code_scanner`

    isLoading = false;
    notifyListeners();
  }

  Future<void> scanFromGallery(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final inputImage = InputImage.fromFile(File(pickedFile.path));
      final scanner = GoogleMlKit.vision.barcodeScanner();
      final barcodes = await scanner.processImage(inputImage);

      if (barcodes.isNotEmpty) {
        final paymentData = barcodes.first.rawValue ?? '';

        // ดึงรายการสินค้า (ตัวอย่าง: ดึงทุก product จาก DB)
        final db = DBHelper();
        List<ProductModel> products = await db.getAllProducts();

        // ไปหน้าแสดงบิล
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaymentReceiptView(
              products: products,
              totalAmount: products.fold(0, (sum, item) => sum + item.price),
              paymentData: paymentData,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ไม่พบ QR Code ในภาพ')),
        );
      }

      scanner.close();
    }

    isLoading = false;
    notifyListeners();
  }
}
