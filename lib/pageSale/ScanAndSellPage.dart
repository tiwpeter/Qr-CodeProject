import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../db/database_helper.dart';
import '../models/sale.dart';
import '../models/todo.dart';

class ScanAndSellPage extends StatefulWidget {
  final String result;

  ScanAndSellPage({required this.result});  // Add result parameter

  @override
  _ScanAndSellPageState createState() => _ScanAndSellPageState();
}

class _ScanAndSellPageState extends State<ScanAndSellPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _quantityController = TextEditingController();

  final List<ToDo> _scannedProducts = [];
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
        // Avoid duplicate products in the list
        _scannedProducts.removeWhere((p) => p.barcode == barcode);
        _scannedProducts.add(product);
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
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    for (var product in _scannedProducts) {
      total += product.price * quantity;
    }
    setState(() {
      _totalPrice = total;
    });
  }

  Future<void> _recordSale() async {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    if (_scannedProducts.isEmpty || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No products scanned or invalid quantity')),
      );
      return;
    }

    for (var product in _scannedProducts) {
      if (quantity > product.quantity) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Insufficient quantity for ${product.name}')),
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

    _quantityController.clear();
    setState(() {
      _scannedProducts.clear();
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
        title: const Text('Scan and Sell'),
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
      return ListTile(
        title: Text(product.name ?? 'Unknown Product'), // Handle null for name
        subtitle: Text('Price: ${product.price.toStringAsFixed(2)} THB'), // Handle price formatting
      );
    },
  ),
),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => _calculateTotalPrice(),
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
