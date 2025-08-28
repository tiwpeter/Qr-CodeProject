import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../db/db_helper.dart';
import '../models/ProductModel.dart';
import '../services/barcode_service.dart';

class AddProductView extends StatefulWidget {
  final String? barcode; // <-- ประกาศ field

  const AddProductView({super.key, this.barcode}); // <-- ใช้ field ที่ประกาศ
  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  @override
  void initState() {
    super.initState();
    // ถ้ามี barcode จาก parent ให้เติมลงใน controller
    if (widget.barcode != null) {
      _barcodeController.text = widget.barcode!;
      _isBarcodeScanned = true;
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final DBHelper _dbHelper = DBHelper();
  final BarcodeService _barcodeService = BarcodeService();

  bool _isBarcodeScanned = false;

  Future<void> scanBarcode() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final result =
        await _barcodeService.scanBarcodeFromImage(File(pickedFile.path));

    if (result != null && result.value != null) {
      // เช็คว่ามี barcode ซ้ำใน DB หรือไม่
      final existingProducts = await _dbHelper.getAllProducts();
      final exists = existingProducts.any((p) => p.barcode == result.value);

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Barcode นี้มีอยู่แล้ว')),
        );
      } else {
        setState(() {
          _barcodeController.text = result.value!;
          _isBarcodeScanned = true; // อนุญาตให้กรอกข้อมูลเพิ่มเติม
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่พบ Barcode ในภาพ')),
      );
    }
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _barcodeService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มสินค้า')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: scanBarcode,
              child: const Text('สแกน Barcode จากภาพ'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _barcodeController,
              decoration: const InputDecoration(
                labelText: 'Barcode',
                border: OutlineInputBorder(),
              ),
              readOnly: true, // ไม่ให้แก้ไขเอง
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'ชื่อสินค้า',
                border: OutlineInputBorder(),
              ),
              enabled: _isBarcodeScanned, // กรอกได้หลังสแกน
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
                      );
                      await _dbHelper.insertProduct(product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('เพิ่มสินค้าเรียบร้อย')),
                      );
                      Navigator.pop(context);
                    },
              child: const Text('บันทึกสินค้า'),
            ),
          ],
        ),
      ),
    );
  }
}
