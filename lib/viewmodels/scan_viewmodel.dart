import 'package:flutter/material.dart';
import 'package:poject_qr/models/ProductModel.dart';

class ScanViewModel extends ChangeNotifier {
  int _currentIndex = -1;

  final List<ProductModel> _products = [
    ProductModel(
      barcode: "123456789",
      name: "Coca Cola 1.5L",
      price: 25,
      imagePath:
          "https://gdb.voanews.com/EEA0B145-95D4-4532-9C69-D0FCD1833D53_w408_r0_s.jpg",
    ),
    ProductModel(
      barcode: "987654321",
      name: "Pepsi 1.5L",
      price: 24,
      imagePath:
          "https://gdb.voanews.com/EEA0B145-95D4-4532-9C69-D0FCD1833D53_w408_r0_s.jpg",
    ),
  ];

  ProductModel? get currentProduct =>
      _currentIndex >= 0 ? _products[_currentIndex] : null;

  void scanNextProduct() {
    _currentIndex = (_currentIndex + 1) % _products.length;
    notifyListeners();
  }
}
