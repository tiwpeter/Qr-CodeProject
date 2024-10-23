import 'package:flutter/material.dart';
import '../models/todo.dart';

class ScannedProductsPage extends StatelessWidget {
  final List<ToDo> scannedProducts;

  ScannedProductsPage({required this.scannedProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Products'),
      ),
      body: ListView.builder(
        itemCount: scannedProducts.length,
        itemBuilder: (context, index) {
          final product = scannedProducts[index];
          return ListTile(
            title: Text(product.name ?? 'Unnamed Product'), // แสดงชื่อสินค้า
            subtitle: Text(
              'Price: \$${product.price.toStringAsFixed(2)}\nQuantity: ${product.quantity}', // แสดงราคาและจำนวน
            ),
          );
        },
      ),
    );
  }
}
