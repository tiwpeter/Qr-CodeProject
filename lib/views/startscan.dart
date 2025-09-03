import 'package:flutter/material.dart';
import 'package:poject_qr/views/ScanPage.dart';
import 'enums/scan_action.dart';

class StartScanPage extends StatelessWidget {
  const StartScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ปุ่มสแกนเพื่อเพิ่มสินค้า
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScanPage(action: ScanAction.addProduct),
                  ),
                );
              },
              child: Text('Scan for Add Product'),
            ),
            SizedBox(height: 12),
            // ปุ่มสแกนเพื่อขายสินค้า
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScanPage(action: ScanAction.sellProduct),
                  ),
                );
              },
              child: Text('Scan for Sell Product'),
            ),
            SizedBox(height: 12),
            // ปุ่มสแกนเพื่อตรวจสอบสต็อก
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScanPage(action: ScanAction.checkStock),
                  ),
                );
              },
              child: Text('Scan for Check Stock'),
            ),
          ],
        ),
      ),
    );
  }
}
