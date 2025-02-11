//
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../db/database_helper.dart';
import '../../../../models/sale.dart';
import '../../../../models/todo.dart';
import 'dart:io';
import './scanned_products_page.dart'; // เพิ่ม import นี้

class ScanAndSellPage extends StatefulWidget {
  final String result;

  ScanAndSellPage({required this.result});

  @override
  _ScanAndSellPageState createState() => _ScanAndSellPageState();
}

class _ScanAndSellPageState extends State<ScanAndSellPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final List<ToDo> _scannedProducts = [];
  final Map<int, int> _productQuantities = {};
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.result.isNotEmpty) {
      _processBarcode(widget.result);
    }
  }

  Future<void> _pickImageAndScan() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
      return;
    }

    final inputImage = InputImage.fromFilePath(pickedFile.path);
    final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

    try {
      final barcodes = await barcodeScanner.processImage(inputImage);
      if (barcodes.isNotEmpty) {
        for (final barcode in barcodes) {
          final displayValue = barcode.displayValue ?? 'No result';
          _processBarcode(displayValue);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No barcode found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    } finally {
      await barcodeScanner.close();
    }
  }

  Future<void> _processBarcode(String barcode) async {
    final product = await _dbHelper.getTodoByBarcode(barcode);
    if (product != null) {
      setState(() {
        if (!_scannedProducts.contains(product)) {
          _scannedProducts.add(product);
          _productQuantities[product.id!] = 1; // Initialize quantity
        }
        _calculateTotalPrice();
      });

      // แสดงป๊อปอัพที่แสดงชื่อสินค้าที่ถูกสแกน พร้อมราคาและรูป
      _showProductPopup(
        product.name ?? 'Unnamed Product',
        product.price,
        product.imagePath,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product not found for this barcode')),
      );
    }
  }

  void _showProductPopup(String productName, double price, String? imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Product Scanned'),
          content: Container(
            width: 250, // กำหนดความกว้างของป๊อปอัพ
            height: 80, // กำหนดความสูงของป๊อปอัพ
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imagePath != null)
                  Image.file(
                    File(imagePath),
                    height: 80, // ปรับขนาดรูปให้เล็กลง
                    width: 80,
                  ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(productName),
                    Text('Price: \$${price.toStringAsFixed(2)}'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    // ปิดป๊อปอัพอัตโนมัติหลังจาก 120 วินาที
    Future.delayed(Duration(seconds: 120), () {
      Navigator.of(context).pop(); // ปิดป๊อปอัพ
    });
  }

  void _calculateTotalPrice() {
    double total = 0.0;
    for (var product in _scannedProducts) {
      final quantity = _productQuantities[product.id!] ?? 0;
      total += product.price * quantity;
    }
    setState(() {
      _totalPrice = total;
    });
  }

  Future<void> _recordSale() async {
    if (_scannedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No products scanned')),
      );
      return;
    }

    for (var product in _scannedProducts) {
      final quantity = _productQuantities[product.id!] ?? 0;
      if (quantity <= 0 || quantity > product.quantity) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid quantity for ${product.name}')),
        );
        return;
      }

      final sale = Sale(
        todoId: product.id!,
        quantity: quantity,
        total: product.price * quantity,
        date: DateTime.now(),
      );

      await _dbHelper.insertSale(sale);
      await _dbHelper.updateToDo(ToDo(
        id: product.id,
        task: product.task,
        isDone: product.isDone,
        barcode: product.barcode,
        imagePath: product.imagePath,
        name: product.name,
        price: product.price,
        quantity: product.quantity - quantity,
      ));
    }

    setState(() {
      _scannedProducts.clear();
      _productQuantities.clear();
      _totalPrice = 0.0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sales recorded successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          border: Border.all(color: Colors.blueGrey[100]!, width: 2),
        ),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImageAndScan,
              child: const Text('Select Image and Scan Barcode'),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScannedProductsPage(
                              scannedProducts: _scannedProducts,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
