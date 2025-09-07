import 'dart:io';
import 'package:flutter/material.dart';
import 'package:poject_qr/viewmodels/ProductImage.dart';
import 'package:provider/provider.dart';
import '../db/db_helper.dart';
import '../models/ProductModel.dart';
import 'package:image_picker/image_picker.dart';

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
  final _quantityController = TextEditingController();
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
    _quantityController.dispose();
    super.dispose();
  }

  void _showPickOptionsDialog(
      BuildContext context, ProductImage productImageVM) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('กล้อง'),
              onTap: () {
                Navigator.of(context).pop();
                productImageVM.pickProductImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('แกลเลอรี่'),
              onTap: () {
                Navigator.of(context).pop();
                productImageVM.pickProductImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductImage>(
      create: (_) => ProductImage(),
      child: Consumer<ProductImage>(
        builder: (context, productImageVM, _) => Scaffold(
          appBar: AppBar(title: const Text('เพิ่มสินค้า')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // -----------------------------
                // เลือกรูปสินค้า ย้ายขึ้นบนสุด
                GestureDetector(
                  onTap: () => _showPickOptionsDialog(context, productImageVM),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: productImageVM.productImage != null
                        ? Image.file(productImageVM.productImage!,
                            fit: BoxFit.cover)
                        : const Icon(Icons.camera_alt,
                            size: 50, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                // -----------------------------

                // Barcode
                TextFormField(
                  controller: _barcodeController,
                  decoration: const InputDecoration(
                    labelText: 'Barcode',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 16),

                // ชื่อสินค้า
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'ชื่อสินค้า',
                    border: OutlineInputBorder(),
                  ),
                  enabled: _isBarcodeScanned,
                ),
                const SizedBox(height: 16),

                // ราคา
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

                // จำนวน
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'จำนวน',
                    border: OutlineInputBorder(),
                  ),
                  enabled: _isBarcodeScanned,
                ),
                const SizedBox(height: 20),

                // บันทึกสินค้า
                ElevatedButton(
                  onPressed: !_isBarcodeScanned
                      ? null
                      : () async {
                          if (_barcodeController.text.isEmpty ||
                              _nameController.text.isEmpty ||
                              _priceController.text.isEmpty ||
                              _quantityController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('กรุณากรอกข้อมูลให้ครบ')),
                            );
                            return;
                          }

                          double? price;
                          int? quantity;
                          try {
                            price = double.parse(_priceController.text);
                            quantity = int.parse(_quantityController.text);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('ราคาและจำนวนต้องเป็นตัวเลข')),
                            );
                            return;
                          }

                          final product = ProductModel(
                            barcode: _barcodeController.text,
                            name: _nameController.text,
                            price: price,
                            imagePath: productImageVM.productImage?.path,
                          );

                          try {
                            final id = await _dbHelper.insertProduct(product);
                            print('Inserted product id: $id');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('เพิ่มสินค้าเรียบร้อย')),
                            );
                            Navigator.pop(context);
                          } catch (e) {
                            print('Insert error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
                            );
                          }
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
