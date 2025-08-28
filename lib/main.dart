import 'package:flutter/material.dart';
import 'package:poject_qr/viewmodels/ScanBarcode.dart';
import 'package:poject_qr/views/BarcodeHistoryView.dart';
import 'package:poject_qr/views/addproducts.dart';
import 'package:poject_qr/views/scantoadd.dart';
import 'package:provider/provider.dart';
import 'viewmodels/barcode_view_model.dart';
import 'views/barcode_view.dart';
import 'views/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BarcodeViewModel()),
        ChangeNotifierProvider(
            create: (_) => ScanBarcodeViewModel()), // เพิ่มตรงนี้
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Menu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BarcodeView()),
                );
              },
              child: const Text('สแกนบาร์โค้ด'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScanBarcodeView()),
                );
              },
              child: const Text('ไปหน้า AddProductView'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BarcodeHistoryView()),
                );
              },
              child: const Text('history'),
            ),
          ],
        ),
      ),
    );
  }
}
