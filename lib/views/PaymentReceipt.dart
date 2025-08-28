import 'package:flutter/material.dart';
import '../models/ProductModel.dart';

class PaymentReceiptView extends StatelessWidget {
  final List<ProductModel> products;
  final double totalAmount;
  final String paymentData;

  const PaymentReceiptView({
    super.key,
    required this.products,
    required this.totalAmount,
    required this.paymentData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('บิลชำระเงิน')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Payment Data: $paymentData',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('Barcode: ${product.barcode}'),
                    trailing: Text('${product.price.toStringAsFixed(2)} ฿'),
                  );
                },
              ),
            ),
            const Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'รวมทั้งหมด',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${totalAmount.toStringAsFixed(2)} ฿',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('กลับหน้าหลัก'),
            ),
          ],
        ),
      ),
    );
  }
}
