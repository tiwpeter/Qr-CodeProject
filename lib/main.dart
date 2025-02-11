import 'package:flutter/material.dart';
import 'package:poject_qr/pages/homepage/startScan/StartToScan.dart';
import 'package:poject_qr/pages/homepage/StockApp.dart';
import 'package:poject_qr/pages/homepage/log/LogInput.dart';
import 'package:poject_qr/pages/homepage/LineChart/LineChartPage%20.dart'; //analysic

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
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

//nav
  final List<Widget> tabs = [
    StartScanPage(), // qr home scan
    StockApp(),
    LineChartPage(),
    LogInput(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/images/qrcode.png', width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/images/stock_1.png', width: 24, height: 24),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/images/revenue.png', width: 24, height: 24),
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
