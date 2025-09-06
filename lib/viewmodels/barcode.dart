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

  List<String> _scannedBarcodes = []; // ✅ เก็บหลายบาร์โค้ด

  List<String> get scannedBarcodes => _scannedBarcodes;

  /// ✅ เลือกรูปจาก Gallery และสแกน
  Future<void> scanFromGallery(
    BuildContext context,
    ScanAction action, {
    Function(ProductModel)? onProductFound, // ✅ เพิ่ม callback
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      _selectedImage = imageFile;
      notifyListeners();

      final result = await _service.scanBarcodeFromImage(imageFile);

      if (result != null && result.value != null) {
        _scannedBarcodes.add(result.value!);
        notifyListeners();

        // หา ProductModel จาก DB
        List<ProductModel> allProducts = await _dbHelper.getAllProducts();
        ProductModel? product = allProducts.firstWhere(
          (p) => p.barcode == result.value,
          orElse: () => ProductModel(
            barcode: result.value!,
            name: 'Unknown',
            price: 0,
          ),
        );

        // เรียก popup ผ่าน callback
        if (onProductFound != null) {
          onProductFound(product);
        }

        // นำทางตาม action
        if (action == ScanAction.addProduct) {
          String lastBarcode = _scannedBarcodes.last;
          _scannedBarcodes.clear();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddProductView(barcode: lastBarcode),
            ),
          );
        }
      }
    }
  }

  /// สแกนจาก Camera
  void addScannedBarcode(String code) {
    if (!_scannedBarcodes.contains(code)) {
      _scannedBarcodes.add(code);
      notifyListeners();
    }
  }

  /// ✅ จัดการหลังสแกนเสร็จ
  Future<void> handleScanComplete(
      BuildContext context, ScanAction action) async {
    if (_scannedBarcodes.isEmpty) return;

    switch (action) {
      case ScanAction.addProduct:
        if (_scannedBarcodes.isNotEmpty) {
          // ✅ เอาเฉพาะตัวล่าสุด (ไม่ต้องใช้ list ทั้งหมด)
          String lastBarcode = _scannedBarcodes.last;

          // ✅ เคลียร์ list เพื่อไม่ให้ค้าง
          _scannedBarcodes.clear();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddProductView(barcode: lastBarcode),
            ),
          );
        }
        break;

      case ScanAction.sellProduct:
        _isLoading = true;
        notifyListeners();

        try {
          List<ProductModel> allProducts = await _dbHelper.getAllProducts();

          // ✅ หา product ที่ barcode อยู่ใน _scannedBarcodes
          List<ProductModel> matchedProducts = allProducts
              .where((p) => _scannedBarcodes.contains(p.barcode))
              .toList();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SellProductView(
                products: matchedProducts,
                scannedBarcodes: _scannedBarcodes, // ✅ ส่ง list ไป
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
