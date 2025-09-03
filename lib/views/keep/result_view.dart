import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  final Map<String, dynamic> product;
  const ResultView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ผลการค้นหาสินค้า')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ชื่อสินค้า: ${product['name']}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('ราคา: ${product['price']} บาท',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
