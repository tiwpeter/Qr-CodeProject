import 'package:flutter/material.dart';
import 'package:poject_qr/db/db_helper.dart';
import 'package:poject_qr/viewmodels/barcode.dart';
import 'package:poject_qr/viewmodels/stock_viewmodel.dart';
import 'package:poject_qr/views/dashboad.dart';
import 'package:poject_qr/views/getAllProducts.dart';
import 'package:poject_qr/views/scan_product_page.dart';
import 'package:poject_qr/views/startscan.dart';
import 'package:poject_qr/views/stock_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // สำคัญสำหรับ async ก่อน runApp

  // เรียกสร้าง database
  await DBHelper().database;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BarcodeViewModel()),
        ChangeNotifierProvider(
            create: (_) => ProductViewModel()), // << เพิ่มตรงนี้
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // เพิ่ม const
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      ),
      home: MainTabPage(),
    );
  }
}

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});
  @override
  _MainTabPageState createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  int _currentIndex = 0;

  // ลบ const เพราะ constructor ไม่ใช่ const
  final List<Widget> _pages = [
    StartScanPage(),
    StockPage(),
    Dashboard(),
    // ScanProductPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/images/qrcode.png', width: 16, height: 16),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/images/stock_1.png', width: 16, height: 16),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/images/revenue.png', width: 16, height: 16),
            label: 'Dashboad',
          ),
        ],
      ),
    );
  }
}

// หน้าต่างๆ ของแต่ละ tab
class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Search Page"));
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Profile Page"));
  }
}
