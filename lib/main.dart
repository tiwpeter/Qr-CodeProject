import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr;
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as ml;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BarCode'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? scanResult;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 300,
          width: double.infinity,
          child: Card(
            child: Center(
              child: Text(
                scanResult ?? "Scan a QR code or pick an image",
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _startScan,
            child: const Icon(Icons.qr_code_scanner_sharp),
            heroTag: 'scan',
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _pickImage,
            child: const Icon(Icons.image),
            heroTag: 'pickImage',
          ),
        ],
      ),
    );
  }

  Future<void> _startScan() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => qr.QRView(
          key: GlobalKey(debugLabel: 'QR'),
          onQRViewCreated: (qr.QRViewController controller) {
            controller.scannedDataStream.listen((scanData) {
              setState(() {
                scanResult = scanData.code;
              });
              Navigator.pop(context);
            });
          },
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final inputImage = ml.InputImage.fromFilePath(image.path);
      final barcodeScanner = ml.GoogleMlKit.vision.barcodeScanner();
      final List<ml.Barcode> barcodes = await barcodeScanner.processImage(inputImage);
      for (ml.Barcode barcode in barcodes) {
        setState(() {
          scanResult = barcode.rawValue;
        });
      }
    }
  }
}
