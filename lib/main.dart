import 'package:flutter/material.dart';
import 'package:poject_qr/page/Home.dart';
import 'package:poject_qr/page/moody_mental_health_app.dart';
import 'package:poject_qr/page/news_1.dart';
import 'package:poject_qr/page/workout_app.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  final tabs = [
    Home(),
    WorkoutApp(),
    News1(),
    MoodyMentalHealthApp(),
    
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
