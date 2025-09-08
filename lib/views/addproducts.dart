import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../models/ProductModel.dart';
import '../viewmodels/ProductImage.dart';
import '../viewmodels/product_viewmodel.dart';

class ProductFormView extends StatefulWidget {
  final ProductModel? product;
  final String? scannedBarcode; // รับ barcode

  const ProductFormView(
      {super.key,
      this.product,
      this.scannedBarcode}); // ✅ เพิ่ม named parameter

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final _barcodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  bool _isBarcodeScanned = false;

  @override
  void initState() {
    super.initState();

    // ถ้ามี product อยู่แล้ว ให้ใช้ข้อมูล product
    if (widget.product != null) {
      _barcodeController.text = widget.product!.barcode;
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _quantityController.text = widget.product!.quantity.toString();
      _isBarcodeScanned = true;
    }
    // ถ้าเป็น scannedBarcode จากการสแกน
    else if (widget.scannedBarcode != null) {
      _barcodeController.text = widget.scannedBarcode!;
      _isBarcodeScanned = true; // เปิดให้กรอกข้อมูล
    }
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

  void _save(BuildContext context, ProductImage productImageVM) async {
    if (_barcodeController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบ')),
      );
      return;
    }

    double? price;
    int? quantity;
    try {
      price = double.parse(_priceController.text);
      quantity = int.parse(_quantityController.text);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ราคาและจำนวนต้องเป็นตัวเลข')),
      );
      return;
    }

    final product = ProductModel(
      id: widget.product?.id,
      barcode: _barcodeController.text,
      name: _nameController.text,
      price: price,
      quantity: quantity,
      imagePath: productImageVM.productImage?.path ?? widget.product?.imagePath,
    );

    final viewModel = context.read<ProductFormViewModel>();
    await viewModel.saveProduct(product, isEdit: widget.product != null);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(widget.product != null
              ? 'แก้ไขสินค้าเรียบร้อย'
              : 'เพิ่มสินค้าเรียบร้อย')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                ProductImage(initialPath: widget.product?.imagePath)),
        ChangeNotifierProvider(create: (_) => ProductFormViewModel()),
      ],
      child: Consumer2<ProductImage, ProductFormViewModel>(
        builder: (context, productImageVM, formVM, _) => Scaffold(
          appBar: AppBar(
            title: Text(isEditing ? 'แก้ไขสินค้า' : 'เพิ่มสินค้า'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
                        : (widget.product?.imagePath != null
                            ? Image.file(File(widget.product!.imagePath!),
                                fit: BoxFit.cover)
                            : const Icon(Icons.camera_alt,
                                size: 50, color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 20),
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
                formVM.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: !_isBarcodeScanned
                            ? null
                            : () => _save(context, productImageVM),
                        child:
                            Text(isEditing ? 'อัพเดทสินค้า' : 'บันทึกสินค้า'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
