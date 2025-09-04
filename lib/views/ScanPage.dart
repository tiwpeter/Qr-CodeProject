import 'package:flutter/material.dart';
import 'package:poject_qr/viewmodels/barcode.dart';
import 'package:provider/provider.dart';
import 'enums/scan_action.dart';

class ScanPage extends StatelessWidget {
  final ScanAction action;

  const ScanPage({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BarcodeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),
        backgroundColor: Colors.deepPurple,
        actions: [
          // แสดงไอคอนนำทางไปหน้าขายสินค้าเฉพาะตอน action เป็น sellProduct
          if (action == ScanAction.sellProduct)
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'ไปหน้าขายสินค้า',
              onPressed: viewModel.scannedBarcodes.isEmpty
                  ? null
                  : () async {
                      await viewModel.handleScanComplete(context, action);
                    },
            ),
        ],
      ),
      body: Stack(
        children: [
          // กล้องสแกน (แสดงเป็น Container แทนกล้องจริงตอนนี้)
          Container(
            color: Colors.black12,
            child: Center(
              child: Icon(
                Icons.qr_code_scanner,
                size: 120,
                color: Colors.grey[700],
              ),
            ),
          ),

          // Overlay UI ด้านบน
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (viewModel.isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.deepPurple),
                  ),

                const SizedBox(height: 10),

                // แสดงรายการที่สแกนแล้ว
                if (viewModel.scannedBarcodes.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'รายการที่สแกนแล้ว',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 100,
                          child: ListView(
                            children: viewModel.scannedBarcodes
                                .map((code) => Text('- $code'))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // ปุ่ม action ด้านล่าง
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await viewModel.scanFromGallery(context, action);
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text('เลือกภาพจาก Gallery'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
