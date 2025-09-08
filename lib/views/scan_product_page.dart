import 'package:flutter/material.dart';
import 'package:poject_qr/views/SlideInProduct.dart';
import 'package:poject_qr/views/enums/scan_action.dart';
import 'package:provider/provider.dart';
import '../models/ProductModel.dart';
import '../viewmodels/scan_viewmodel.dart';
import '../viewmodels/barcode.dart';

class ScanProductPage extends StatelessWidget {
  const ScanProductPage({super.key, required this.action});

  final ScanAction action;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScanViewModel(),
      child: ScanProductView(action: action),
    );
  }
}

class ScanProductView extends StatelessWidget {
  const ScanProductView({super.key, required this.action});

  final ScanAction action;

  void _showProductPopup(BuildContext context, ProductModel product) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 50,
        left: 16,
        right: 16,
        child: SlideInProduct(product: product),
      ),
    );

    overlay.insert(entry);

    // ปิด popup อัตโนมัติหลัง 2 วินาที
    Future.delayed(const Duration(seconds: 8), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ScanViewModel>(context);
    final barcodeVM = Provider.of<BarcodeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),
        backgroundColor: Colors.deepPurple,
        actions: [
          if (action == ScanAction.sellProduct)
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'ไปหน้าขายสินค้า',
              onPressed: barcodeVM.scannedBarcodes.isEmpty
                  ? null
                  : () async {
                      await barcodeVM.handleScanComplete(context, action);
                    },
            ),
        ],
      ),
      body: Container(
        color: Colors.black12,
        child: GestureDetector(
          onTap: () {
            vm.scanNextProduct();
            if (vm.currentProduct != null && action != ScanAction.addProduct) {
              _showProductPopup(context, vm.currentProduct!);
            }
          },
          child: Center(
            child: Icon(
              Icons.qr_code_scanner,
              size: 120,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await barcodeVM.scanFromGallery(
            context,
            action,
            onProductFound: (product) {
              // ✅ แสดง popup เฉพาะ action ที่ไม่ใช่ addProduct และ product ไม่เป็น null
              if (action != ScanAction.addProduct && product != null) {
                _showProductPopup(context, product);
              }
            },
          );
        },
        child: const Icon(Icons.photo_library),
      ),
    );
  }
}
