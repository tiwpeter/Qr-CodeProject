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
            if (viewModel.selectedImage != null)
              Image.file(viewModel.selectedImage!, height: 200),
            if (viewModel.result != null)
              Text("Scanned: ${viewModel.result!.value}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await viewModel.scanFromGallery();
                await viewModel.handleScanComplete(context, action);
              },
              child: const Text('เลือกภาพจาก Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
