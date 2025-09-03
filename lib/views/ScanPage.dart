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
      appBar: AppBar(title: const Text('Scan Page')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (viewModel.isLoading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
            ],
            if (viewModel.scannedBarcodes.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('รายการที่สแกนแล้ว:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ...viewModel.scannedBarcodes
                      .map((code) => Text('- $code'))
                      .toList(),
                ],
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await viewModel.scanFromGallery(context, action);

                // สำหรับ addProduct จะนำทางแล้ว ไม่ต้องเรียก handleScanComplete
                if (action != ScanAction.addProduct) {
                  await viewModel.handleScanComplete(context, action);
                }
              },
              child: const Text('เลือกภาพจาก Gallery'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.scannedBarcodes.isEmpty
                  ? null
                  : () async {
                      await viewModel.handleScanComplete(context, action);
                    },
              child: const Text('ไปหน้าขายสินค้า'),
            ),
          ],
        ),
      ),
    );
  }
}
