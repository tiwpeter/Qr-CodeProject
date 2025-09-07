// viewmodels/todo_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:poject_qr/models/ProductModel.dart';

class ProductViewModel extends ChangeNotifier {
  final List<ProductModel> _products = [
    ProductModel(
      id: 1,
      barcode: '123456789',
      name: 'Product A',
      price: 100.0,
      imagePath: 'assets/Shose.jpg',
      quantity: 10,
    ),
    ProductModel(
      id: 2,
      barcode: '987654321',
      name: 'Product B',
      price: 150.0,
      imagePath: 'assets/Shose.jpg',
      quantity: 5,
    ),
  ];

  List<ProductModel> get products => List.unmodifiable(_products);

  // Create
  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  // Read (find by barcode)
  ProductModel? getByBarcode(String barcode) {
    try {
      return _products.firstWhere((p) => p.barcode == barcode);
    } catch (e) {
      return null;
    }
  }
}
