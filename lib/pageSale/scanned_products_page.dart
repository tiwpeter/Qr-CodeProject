import 'package:flutter/material.dart';
import 'dart:io';
import '../models/todo.dart';

class ScannedProductsPage extends StatelessWidget {
  final List<ToDo> scannedProducts;

  ScannedProductsPage({required this.scannedProducts});

  @override
  Widget build(BuildContext context) {
    double totalPrice = _calculateTotalPrice(scannedProducts);

    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Products'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: scannedProducts.length,
              itemBuilder: (context, index) {
                final product = scannedProducts[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: product.imagePath != null
                        ? Image.file(
                            File(product.imagePath!),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : SizedBox.shrink(),
                    title: Text(product.name ?? 'Unnamed Product'),
                    subtitle: Text(
                      'Price: ${product.price.toStringAsFixed(2)} THB\nQuantity: ${product.quantity}',
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ราคารวม',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalPrice.toStringAsFixed(2)} THB',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      _recordSale(scannedProducts);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'ชำระเงิน',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotalPrice(List<ToDo> products) {
    double total = 0.0;
    for (var product in products) {
      total += product.price * product.quantity;
    }
    return total;
  }

  void _recordSale(List<ToDo> products) {
    // Implement your sale recording logic here
    // For example, you might want to save to a database or show a confirmation dialog
    print('Recording sale for products: $products');
  }
}
