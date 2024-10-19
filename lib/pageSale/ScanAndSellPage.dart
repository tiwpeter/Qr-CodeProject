import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../db/database_helper.dart';
import '../models/sale.dart';
import '../models/todo.dart';
import 'dart:io';

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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product not found for this barcode')),
      );
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImageAndScan,
              child: const Text('Select Image and Scan Barcode'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _scannedProducts.length,
                itemBuilder: (context, index) {
                  final product = _scannedProducts[index];
                  final quantity = _productQuantities[product.id!] ?? 0;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the container
                      borderRadius:
                          BorderRadius.circular(12.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Shadow color
                          blurRadius: 4.0, // Shadow blur radius
                          offset: Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 8), // ระยะห่างระหว่างรายการ
                    child: ListTile(
                      leading: product.imagePath != null
                          ? Image.file(
                              File(product.imagePath!),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : SizedBox.shrink(),
                      title: Text(product.name ?? 'Unknown Product'),
                      subtitle: Text(
                          'Price: ${product.price.toStringAsFixed(2)} THB'),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) {
                                    _productQuantities[product.id!] =
                                        quantity - 1;
                                    _calculateTotalPrice();
                                  }
                                });
                              },
                            ),
                            Text('$quantity', style: TextStyle(fontSize: 16)),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  _productQuantities[product.id!] =
                                      quantity + 1;
                                  _calculateTotalPrice();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text('Total Price: ${_totalPrice.toStringAsFixed(2)} THB'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _recordSale,
              child: const Text('Sell'),
            ),
          ],
        ),
      ),
    );
  }
}
