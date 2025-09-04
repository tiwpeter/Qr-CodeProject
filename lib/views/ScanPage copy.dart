import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barcode Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ScanProductPage(),
    );
  }
}

class ScanProductPage extends StatefulWidget {
  const ScanProductPage({super.key});

  @override
  State<ScanProductPage> createState() => _ScanProductPageState();
}

class _ScanProductPageState extends State<ScanProductPage> {
  int index = -1;

  // จำลองข้อมูลสินค้า
  final mockProducts = [
    {
      "barcode": "123456789",
      "name": "Coca Cola 1.5L",
      "price": 25,
      "image":
          "https://gdb.voanews.com/EEA0B145-95D4-4532-9C69-D0FCD1833D53_w408_r0_s.jpg"
    },
    {
      "barcode": "987654321",
      "name": "Pepsi 1.5L",
      "price": 24,
      "image":
          "https://gdb.voanews.com/EEA0B145-95D4-4532-9C69-D0FCD1833D53_w408_r0_s.jpg"
    },
  ];

  void onScan(BuildContext context) {
    setState(() {
      index = (index + 1) % mockProducts.length;
    });

    final product = mockProducts[index];

    _showProductPopup(context, product);
  }

  void _showProductPopup(BuildContext context, Map<String, dynamic> product) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 50,
          left: 16,
          right: 16,
          child: SlideInProduct(product: product),
        );
      },
    );

    overlay.insert(entry);

    // ปิดเองอัตโนมัติหลัง 2 วินาที
    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("สแกนสินค้า"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // ไปหน้าตะกร้า
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => onScan(context),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            height: 200,
            child: const Center(
              child: Text(
                "📷 แตะเพื่อจำลองการสแกน",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.flash_on),
      ),
    );
  }
}

class SlideInProduct extends StatefulWidget {
  final Map<String, dynamic> product;

  const SlideInProduct({super.key, required this.product});

  @override
  State<SlideInProduct> createState() => _SlideInProductState();
}

class _SlideInProductState extends State<SlideInProduct>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
            .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.network(
                widget.product["image"],
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product["name"],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("ราคา: ${widget.product["price"]} บาท"),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  // เพิ่มลงตะกร้า
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
