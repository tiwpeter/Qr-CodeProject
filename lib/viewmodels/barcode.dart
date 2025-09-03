import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poject_qr/db/db_helper%20copy.dart';
import 'package:poject_qr/models/ProductModel.dart';
import 'package:poject_qr/models/barcode_result.dart';
import 'package:poject_qr/services/barcode_service.dart';
import 'package:poject_qr/views/SellProductView.dart';
import 'package:poject_qr/views/addproducts.dart';
import 'package:poject_qr/views/enums/scan_action.dart';

class BarcodeViewModel extends ChangeNotifier {
  final BarcodeService _service = BarcodeService();
  final DBHelper _dbHelper = DBHelper();
  BarcodeResultModel? _result;
  File? _selectedImage;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  BarcodeResultModel? get result => _result;
  File? get selectedImage => _selectedImage;

  /// ✅ เลือกรูปจาก Gallery และสแกน
  Future<void> scanFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    _selectedImage = File(pickedFile.path);
    _isLoading = true;
    notifyListeners();

    try {
      _result = await _service.scanBarcodeFromImage(_selectedImage!);
    } catch (e) {
      print("Error scanning image: $e");
      _result = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// ✅ จัดการหลังสแกนเสร็จ
  Future<void> handleScanComplete(
      BuildContext context, ScanAction action) async {
    if (_result == null || _result!.value == null) return;

    String barcode = _result!.value!;

    switch (action) {
      case ScanAction.addProduct:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddProductView(barcode: barcode), // ส่ง barcode ไป
          ),
        );
        break;

      case ScanAction.sellProduct:
        _isLoading = true;
        notifyListeners();

        try {
          List<ProductModel> allProducts = await _dbHelper.getAllProducts();
          List<ProductModel> matchedProducts =
              allProducts.where((p) => p.barcode == barcode).toList();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SellProductView(
                products: matchedProducts,
                scannedBarcode: barcode,
              ),
            ),
          );
        } catch (e) {
          debugPrint('Error fetching products: $e');
        } finally {
          _isLoading = false;
          notifyListeners();
        }
        break;

      case ScanAction.checkStock:
        // TODO: logic ตรวจสอบสต็อก
        break;
    }
  }

  /// ✅ ปิด resource ของ Service
  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
