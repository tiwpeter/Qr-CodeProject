import 'package:flutter/material.dart';
import 'package:poject_qr/viewmodels/ScanBarcode.dart';
import 'package:provider/provider.dart';

class ScanBarcodeView extends StatelessWidget {
  const ScanBarcodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ScanBarcodeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('สแกน Barcode')),
      body: Center(
        child: vm.isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('สแกนด้วยกล้อง'),
                    onPressed: () => vm.scanFromCamera(context),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.photo),
                    label: const Text('เลือกจาก Gallery'),
                    onPressed: () => vm.scanFromGallery(context),
                  ),
                ],
              ),
      ),
    );
  }
}
