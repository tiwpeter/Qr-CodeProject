import 'package:flutter/material.dart';
import 'package:poject_qr/models/ProductModel.dart';

class SellProductView extends StatelessWidget {
  final List<ProductModel> products;
  final String scannedBarcode;

  const SellProductView({
    super.key,
    required this.products,
    required this.scannedBarcode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ขายสินค้า')),
      body: products.isEmpty
          ? Center(child: Text('ไม่พบสินค้า: $scannedBarcode'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('ราคา: ${product.price} บาท'),
                );
              },
            ),
    );
  }
}
