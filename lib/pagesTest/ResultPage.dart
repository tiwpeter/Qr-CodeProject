import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

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
          final barcode = barcodes.first.displayValue ?? 'No result';
          setState(() {
            result = barcode;
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
        title: Text('ตระกร้า'),
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
            onPressed: _pickImageAndScan,
            child: Text('Scan Another'),
          ),
        ],
      ),
    );
  }
}
