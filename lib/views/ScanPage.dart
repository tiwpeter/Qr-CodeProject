//create bill
// create page scan send value to addproduct
import 'package:flutter/material.dart';
import 'package:poject_qr/views/Test.dart';
import './enums/scan_action.dart';

class ScanPage extends StatelessWidget {
  final ScanAction action;

  const ScanPage({super.key, required this.action});

  void onScanComplete(BuildContext context, String barcode) {
    if (action == ScanAction.addProduct) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddProductPage(barcode: barcode),
        ),
      );
    } else if (action == ScanAction.sellProduct) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // สมมติสแกนเสร็จแล้วได้ barcode
            String barcode = "12345";
            onScanComplete(context, barcode);
          },
          child: Text('Simulate Scan'),
        ),
      ),
    );
  }
}
