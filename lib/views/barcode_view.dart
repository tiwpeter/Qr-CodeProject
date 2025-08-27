import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../viewmodels/barcode_view_model.dart';

class BarcodeView extends StatelessWidget {
  const BarcodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BarcodeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Scan Barcode from Gallery')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  await viewModel.scanFromGallery(File(pickedFile.path));
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
