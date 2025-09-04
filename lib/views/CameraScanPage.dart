import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MultiScanPage extends StatelessWidget {
  const MultiScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('สแกนหลายตัว'),
      ),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          final barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            print('สแกน: ${barcode.rawValue}');
          }
        },
      ),
    );
  }
}
