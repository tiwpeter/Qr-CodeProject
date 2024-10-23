import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:poject_qr/pageSale/ScanAndSellPage.dart';
import 'package:poject_qr/pages/qrcode.dart';

void main() {
  runApp(MyPageQr2());
}

class MyPageQr2 extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageAndScan(BuildContext context) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final inputImage = InputImage.fromFilePath(pickedFile.path);
        final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
        final barcodes = await barcodeScanner.processImage(inputImage);

        if (barcodes.isNotEmpty) {
          final barcode = barcodes.first.displayValue ?? 'No result';
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanAndSellPage(result: barcode),
            ),
          );
        } else {
          _showSnackBar(context, 'No barcode found');
        }
      }
    } catch (e) {
      _showSnackBar(context, 'Error occurred: $e');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('shop_one', style: TextStyle(fontSize: 18)),
                SizedBox(width: 10),
                CustomButton(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('find', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    // Handle button press
                  },
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Container(
                      alignment: Alignment.center,
                      width: 270,
                      height: 200,
                      color: Colors.grey[200],
                      child: Text('view_two'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 42),
                          child: Text('Add', style: TextStyle(fontSize: 16)),
                        ),
                        GestureDetector(
                          onTap: () => _pickImageAndScan(context),
                          child: CustomButton(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('sell',
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 42),
                          child: Text('search', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              _navigateToAddPage(context, 'Add icon clicked'),
                          child: Image.asset('assets/icon/add.png', height: 32),
                        ),
                        SizedBox(width: 64),
                        GestureDetector(
                          onTap: () => _navigateToResultPage(
                              context, 'Up-selling icon clicked'),
                          child: Image.asset('assets/icon/up-selling.png',
                              height: 32),
                        ),
                        SizedBox(width: 64),
                        GestureDetector(
                          onTap: () => _navigateToResultPage(
                              context, 'Loupe icon clicked'),
                          child:
                              Image.asset('assets/icon/loupe.png', height: 32),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 72, // Set a width for the circle
                      height: 72, // Set a height for the circle
                      margin: EdgeInsets.only(top: 60, bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle, // Make it a circle
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToResultPage(BuildContext context, String result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanAndSellPage(result: result),
      ),
    );
  }

  void _navigateToAddPage(BuildContext context, String result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeScannerScreen(result: result),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final BoxDecoration decoration;
  final Widget child;
  final VoidCallback? onPressed;

  CustomButton({
    required this.decoration,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: decoration,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: child,
      ),
    );
  }
}
