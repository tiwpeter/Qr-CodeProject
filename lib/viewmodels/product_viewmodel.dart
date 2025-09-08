import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/ProductModel.dart';

class ProductFormViewModel extends ChangeNotifier {
  final DBHelper _dbHelper = DBHelper();

  bool isLoading = false;

  Future<void> saveProduct(ProductModel product, {bool isEdit = false}) async {
    isLoading = true;
    notifyListeners();

    try {
      if (isEdit) {
        //await _dbHelper.updateProduct(product);
      } else {
        await _dbHelper.insertProduct(product);
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
