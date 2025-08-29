import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget {
  final String barcode; // รับ barcode

  const AddProductPage({super.key, required this.barcode}); // constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Center(child: Text('Barcode: $barcode')),
    );
  }
}
