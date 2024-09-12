import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

void main() {
  runApp(MyPageQr2());
}

class MyPageQr2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageAndScan(BuildContext context) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final inputImage = InputImage.fromFilePath(pickedFile.path);
        final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
        final barcodes = await barcodeScanner.processImage(inputImage);

        if (barcodes.isNotEmpty) {
          final barcode = barcodes.first;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(result: barcode.displayValue ?? 'No result'),
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
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              AppBar(
                toolbarHeight: 72,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'shop_one',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    CustomButton(
                      decoration: BoxDecoration(
                        color: Colors.blue, // Example color, adjust as needed
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'find',
                        style: TextStyle(color: Colors.white), // Ensure text is visible
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
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
                        color: Colors.grey[200], // Example color for view_two
                        child: Text('view_two'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 42), // Increased spacing
                            child: Text('Add', style: TextStyle(fontSize: 16)),
                          ),
                          GestureDetector(
                            onTap: () => _pickImageAndScan(context), // ฟังก์ชันสำหรับการเลือกภาพและสแกนบาร์โค้ด
                            child: CustomButton(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue), // Example border color
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('sell', style: TextStyle(color: Colors.blue)), // Ensure text is visible
                              alignment: Alignment.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 42), // Increased spacing
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
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _navigateToResultPage(context, 'Add icon clicked'),
                          child: Image.asset('assets/icon/add.png', height: 32),
                        ),
                      ],
                    ),
                    SizedBox(width: 64), // Spacing between images
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _navigateToResultPage(context, 'Up-selling icon clicked'),
                          child: Image.asset('assets/icon/up-selling.png', height: 32),
                        ),
                      ],
                    ),
                    SizedBox(width: 64), // Spacing between images
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _navigateToResultPage(context, 'Loupe icon clicked'),
                          child: Image.asset('assets/icon/loupe.png', height: 32),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 84,
                  margin: EdgeInsets.only(top: 78, bottom: 4),
                  color: Colors.grey[300], // Example color for view_one
                  child: Text('view_one'),
                ),
              ],
            ),
          ),
        ),
      ],
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

  CustomButton({required this.decoration, required this.child, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      alignment: alignment,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Added padding for better button appearance
      child: child,
    );
  }
}

class ResultPage extends StatefulWidget {
  final String result;

  ResultPage({required this.result});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late String result;
  List<String> results = [];

  @override
  void initState() {
    super.initState();
    result = widget.result;
    results.add(result);
  }

  Future<void> _pickImageAndScan() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final inputImage = InputImage.fromFilePath(pickedFile.path);
        final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
        final barcodes = await barcodeScanner.processImage(inputImage);

        if (barcodes.isNotEmpty) {
          final barcode = barcodes.first;
          setState(() {
            result = barcode.displayValue ?? 'No result';
            results.add(result);
          });
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
      appBar: AppBar(
        title: Text('Result Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Scanned Barcode ${index + 1}: ${results[index]}'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _pickImageAndScan();
            },
            child: Text('Scan Another'),
          ),
        ],
      ),
    );
  }
}
