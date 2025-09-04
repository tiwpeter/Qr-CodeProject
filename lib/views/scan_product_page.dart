import 'package:flutter/material.dart';
import 'package:poject_qr/models/ProductModel.dart';
import 'package:poject_qr/viewmodels/scan_viewmodel.dart';
import 'package:poject_qr/views/ScanPage%20copy.dart';
import 'package:provider/provider.dart';

class ScanProductPage extends StatelessWidget {
  const ScanProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScanViewModel(),
      child: const ScanProductView(),
    );
  }
}

class ScanProductView extends StatelessWidget {
  const ScanProductView({super.key});

  void _showProductPopup(BuildContext context, ProductModel product) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 50,
        left: 16,
        right: 16,
        child: SlideInProduct(product: product.toMap()),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ScanViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("สแกนสินค้า"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // ไปหน้าตะกร้า
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          vm.scanNextProduct();
          if (vm.currentProduct != null) {
            _showProductPopup(context, vm.currentProduct!);
          }
        },
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            height: 200,
            child: const Center(
              child: Text(
                "📷 แตะเพื่อจำลองการสแกน",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.flash_on),
      ),
    );
  }
}
