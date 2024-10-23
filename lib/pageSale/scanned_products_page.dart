import 'package:flutter/material.dart';
import 'dart:io';
import '../models/todo.dart';
import '../models/sale.dart';

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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50], // Background color
        ),
        child: Column(
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
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ราคารวม ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                        // Implement payment logic here
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
      ),
    );
  }

  double _calculateTotalPrice(List<ToDo> products) {
    double total = 0.0;
    for (var product in products) {
      total +=
          product.price * product.quantity; // Assuming quantity is a property
    }
    return total;
  }
}
