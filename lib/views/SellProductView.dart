import 'dart:io';
import 'package:flutter/material.dart';
import 'package:poject_qr/models/ProductModel.dart';

class SellProductView extends StatefulWidget {
  final List<ProductModel> products;
  final List<String> scannedBarcodes;

  const SellProductView({
    Key? key,
    required this.products,
    required this.scannedBarcodes,
  }) : super(key: key);

  @override
  State<SellProductView> createState() => _SellProductViewState();
}

class _SellProductViewState extends State<SellProductView> {
  // เก็บจำนวนสินค้าแต่ละตัว
  final Map<dynamic, int> quantities = {};

  double get totalPrice {
    double sum = 0.0;
    for (var p in widget.products) {
      final qty = quantities[p.id ?? widget.products.indexOf(p)] ?? 1;
      sum += (p.price ?? 0) * qty;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ชำระเงิน"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 รายการสินค้า
            const Text(
              "รายการสินค้า",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final p = widget.products[index];
                  final qty = quantities[p.id ?? index] ?? 1; // จำนวนปัจจุบัน

                  return ListTile(
                    leading: p.imagePath != null && p.imagePath!.isNotEmpty
                        ? Image.file(
                            File(p.imagePath!),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.shopping_bag, size: 40),
                    title: Text(p.name),
                    subtitle: Text("฿${p.price}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              if (qty > 1) quantities[p.id ?? index] = qty - 1;
                            });
                          },
                        ),
                        Text("$qty", style: const TextStyle(fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            setState(() {
                              quantities[p.id ?? index] = qty + 1;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔹 ราคารวม
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("ราคารวมทั้งหมด:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("฿$totalPrice",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 วิธีการชำระเงิน
            const Text(
              "เลือกวิธีการชำระเงิน",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  label: const Text("บัตรเครดิต"),
                  selected: false,
                  onSelected: (_) {},
                ),
                ChoiceChip(
                  label: const Text("PromptPay"),
                  selected: true,
                  onSelected: (_) {},
                ),
                ChoiceChip(
                  label: const Text("เก็บเงินปลายทาง"),
                  selected: false,
                  onSelected: (_) {},
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 ปุ่มยืนยัน
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("ยอดรวมทั้งหมด ฿$totalPrice")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.teal,
                ),
                child: const Text("ยืนยันการชำระเงิน",
                    style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
