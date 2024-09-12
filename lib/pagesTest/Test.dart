import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:poject_qr/pagesTest/ResultPage.dart';  // ตรวจสอบว่ามีการสร้าง Homemain widget และ path ถูกต้อง

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
              builder: (context) => ResultPage(result: barcode),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No barcode found')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            toolbarHeight: 72,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'shop_one',
                  style: TextStyle(fontSize: 18),
                ),
                CustomButton(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'find',
                    style: TextStyle(color: Colors.white),
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 38),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 266,
                          color: Colors.grey[200],
                          child: Text('view_two'),
                        ),
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
                                child: Text('sell', style: TextStyle(color: Colors.blue)),
                                alignment: Alignment.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 42),
                              child: Text('search', style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _navigateToResultPage(context, 'Add icon clicked'),
                        child: Image.asset('assets/icon/add.png', height: 32),
                      ),
                      SizedBox(width: 64),
                      GestureDetector(
                        onTap: () => _navigateToResultPage(context, 'Up-selling icon clicked'),
                        child: Image.asset('assets/icon/up-selling.png', height: 32),
                      ),
                      SizedBox(width: 64),
                      GestureDetector(
                        onTap: () => _navigateToResultPage(context, 'Loupe icon clicked'),
                        child: Image.asset('assets/icon/loupe.png', height: 32),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 84,
                    margin: EdgeInsets.only(top: 78, bottom: 4),
                    color: Colors.grey[300],
                    child: Text('view_one'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToResultPage(BuildContext context, String result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(result: result),
      ),
    );
  }
}


class CustomButton extends StatelessWidget {
  final BoxDecoration decoration;
  final Widget child;
  final AlignmentGeometry alignment;

  CustomButton({
    required this.decoration,
    required this.child,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      alignment: alignment,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: child,
    );
  }
}