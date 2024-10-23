import 'package:flutter/material.dart';
import './widgets/line_chart_card.dart'; // Adjust this path as necessary

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Line Chart Example',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LineChartCard(), // Your LineChartCard widget
              // Add more widgets here as needed
            ],
          ),
        ),
      ),
    );
  }
}
