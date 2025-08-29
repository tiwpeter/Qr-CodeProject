import 'package:flutter/material.dart';
import 'package:poject_qr/views/Test.dart'; // AddProductPage
import 'package:provider/provider.dart';
import './enums/scan_action.dart';
import '../viewmodels/barcode_view_model.dart';

class ScanPage extends StatelessWidget {
  final ScanAction action;

  const ScanPage({super.key, required this.action});

  void onScanComplete(BuildContext context, String barcode) {
    switch (action) {
      case ScanAction.addProduct:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddProductView(barcode: barcode),
          ),
        );
        break;
      case ScanAction.sellProduct:
      case ScanAction.checkStock:
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BarcodeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Scan Page')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ปุ่มสแกนจาก Gallery
            ElevatedButton(
              onPressed: () async {
                // เรียก viewModel สแกนภาพ
                await viewModel.pickImageScanAndSearch(context);

                // เมื่อสแกนเสร็จ -> ส่งค่า barcode ไปหน้าอื่นทันที
                if (viewModel.result != null) {
                  String barcode = viewModel.result!.value!;

                  onScanComplete(context, barcode);
                }
              },
              child: const Text('เลือกภาพจาก Gallery'),
            ),
            const SizedBox(height: 20),
            if (viewModel.isLoading) const CircularProgressIndicator(),
            if (viewModel.selectedImage != null && !viewModel.isLoading)
              Image.file(viewModel.selectedImage!),
            const SizedBox(height: 20),
            Text(
              viewModel.result?.value ?? 'ผลการสแกนจะปรากฏที่นี่',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
