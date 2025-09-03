import 'dart:io';
import 'package:flutter/material.dart';
import 'package:poject_qr/viewmodels/ProductImage.dart';
import 'package:provider/provider.dart';
import '../db/db_helper.dart';
import '../models/ProductModel.dart';

class AddProductView extends StatefulWidget {
  final String? barcode;
  const AddProductView({super.key, this.barcode});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _barcodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final DBHelper _dbHelper = DBHelper();
  bool _isBarcodeScanned = false;

  @override
  void initState() {
    super.initState();
    if (widget.barcode != null) {
      _barcodeController.text = widget.barcode!;
      _isBarcodeScanned = true;
    }
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductImage>(
      create: (_) => ProductImage(),
      child: Consumer<ProductImage>(
        builder: (context, productImageVM, _) => Scaffold(
          appBar: AppBar(title: const Text('เพิ่มสินค้า')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _barcodeController,
                  decoration: const InputDecoration(
                    labelText: 'Barcode',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'ชื่อสินค้า',
                    border: OutlineInputBorder(),
                  ),
                  enabled: _isBarcodeScanned,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'ราคา',
                    border: OutlineInputBorder(),
                  ),
                  enabled: _isBarcodeScanned,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await productImageVM.pickProductImage();
                  },
                  child: const Text('เลือกรูปสินค้า'),
                ),
                const SizedBox(height: 8),
                if (productImageVM.productImage != null)
                  Image.file(productImageVM.productImage!, height: 150),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: !_isBarcodeScanned
                      ? null
                      : () async {
                          if (_nameController.text.isEmpty ||
                              _priceController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('กรุณากรอกข้อมูลให้ครบ')),
                            );
                            return;
                          }

                          final product = ProductModel(
                            barcode: _barcodeController.text,
                            name: _nameController.text,
                            price: double.parse(_priceController.text),
                            imagePath: productImageVM.productImage?.path,
                          );
                          await _dbHelper.insertProduct(product);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('เพิ่มสินค้าเรียบร้อย')),
                          );
                          Navigator.pop(context);
                        },
                  child: const Text('บันทึกสินค้า'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
