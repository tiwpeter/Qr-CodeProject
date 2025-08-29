import 'dart:io';
import 'package:flutter/material.dart';
import 'package:poject_qr/models/ProductModel.dart';
import 'package:poject_qr/viewmodels/barcode_view_model.dart';
import 'package:provider/provider.dart';
import '../db/db_helper.dart';

class AddProductView extends StatefulWidget {
  final String barcode;

  const AddProductView({super.key, required this.barcode});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _dbHelper = DBHelper();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveProduct(File? image) async {
    await _dbHelper.insertProduct(ProductModel(
      barcode: widget.barcode,
      name: _nameController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      imagePath: image?.path,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('เพิ่มสินค้าสำเร็จ')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final imageService = Provider.of<BarcodeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (imageService.selectedImage != null)
              Image.file(imageService.selectedImage!, width: 150, height: 150),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => imageService.pickImageFromGallery(),
              child: const Text('เลือกภาพสินค้า'),
            ),
            const SizedBox(height: 10),
            Text('Barcode: ${widget.barcode}'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveProduct(imageService.selectedImage),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
