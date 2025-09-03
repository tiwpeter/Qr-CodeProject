import 'package:flutter/material.dart';
import 'package:poject_qr/models/ProductModel.dart';

class SellProductView extends StatelessWidget {
  final List<ProductModel> products;
  final List<String> scannedBarcodes;

  const SellProductView({
    Key? key,
    required this.products,
    required this.scannedBarcodes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        products.fold(0, (sum, item) => sum + (item.price ?? 0));

    return Scaffold(
      appBar: AppBar(title: const Text('ขายสินค้า')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'บาร์โค้ดที่สแกน:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: scannedBarcodes.map((code) {
                return Chip(
                  label: Text(code),
                  backgroundColor: Colors.blue.shade100,
                );
              }).toList(),
            ),
            const Divider(height: 20),
            Expanded(
              child: products.isEmpty
                  ? Center(
                      child: Text(
                        'ไม่พบสินค้าตรงกับบาร์โค้ดที่สแกน',
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        final product = products[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(product.name),
                            subtitle: Text('ราคา: ${product.price} บาท'),
                          ),
                        );
                      },
                    ),
            ),
            if (products.isNotEmpty) ...[
              const Divider(),
              Text(
                'ราคารวม: $totalPrice บาท',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: ทำฟังก์ชันยืนยันขาย
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('ขายสินค้าสำเร็จ!')),
                    );
                  },
                  icon: const Icon(Icons.check_circle),
                  label: const Text('ยืนยันขาย'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
