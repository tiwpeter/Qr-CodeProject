import 'package:flutter/material.dart';
import 'package:poject_qr/pages/PriceSummaryScreen.dart';
import 'package:poject_qr/pages/Homemain.dart';
import 'package:poject_qr/pages/Homepage.dart';
import 'package:poject_qr/pages/BarCodeSale.dart';
import 'package:poject_qr/pages/qrcode.dart';
import 'package:poject_qr/pages/sales_screen.dart';
import 'package:poject_qr/pages/todo.dart';  // ตรวจสอบว่ามีการสร้าง Homemain widget และ path ถูกต้อง

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyHomePage(title: 'My Home Page'), // เปลี่ยนจาก routes เป็น home
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
  int _currentIndex = 0;

  final List<Widget> tabs = [
    BarCodeSale(), // น้นที่การแสดงข้อมูลการขายที่บันทึกไว้ทั้งหมดและยอดขายรวม
    BarcodeScannerScreen(),
    Todo(),
    SalesScreen(),



    // StockPage(),
    // ProfilePage(),
    // SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/qrcode.png', width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/stock_1.png', width: 24, height: 24),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/revenue.png', width: 24, height: 24),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icon.png', width: 24, height: 24),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
