import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:poject_qr/pages/homepage/startScan/Sell/ScanToSell.dart';
import 'package:poject_qr/pages/homepage/startScan/Add/ScanToAdd.dart';

class StartScanPage extends StatelessWidget {
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
          backgroundColor: Colors.white,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Scan Products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Set font weight to bold
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
            color: Colors.white, // Set the background color to white

            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 270,
                          height: 200,
                          color: Color(0xFFECFDF3), // Adjusted color
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                8), // Optional: round corners
                            child: Image.asset(
                              'assets/icon/ice.png',
                              fit: BoxFit
                                  .cover, // Ensure the image covers the container
                              width: 270, // Optional: can be omitted
                              height: 200, // Optional: can be omitted
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Select your Type to scan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold, // Make the text bold
                          ),
                          textAlign: TextAlign.center, // Center the text
                        ),
                        SizedBox(height: 20), // Optional spacing below the text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 42),
                              child:
                                  Text('Add', style: TextStyle(fontSize: 16)),
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
                              child: Text('search',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => _navigateToAddPage(
                                  context, 'Add icon clicked'),
                              child: Image.asset('assets/icon/add.png',
                                  height: 32),
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
                              child: Image.asset('assets/icon/loupe.png',
                                  height: 32),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 72, // Set a width for the circle
                          height: 72, // Set a height for the circle
                          margin: EdgeInsets.only(top: 56, bottom: 4),
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
            )),
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
