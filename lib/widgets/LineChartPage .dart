import 'package:flutter/material.dart';
import 'line_chart_card.dart'; // Import the LineChartCard you created

class LineChartPage extends StatelessWidget {
  const LineChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steps Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    LineChartCard(), // Include your LineChartCard here
                    SizedBox(height: 20),
                    // You can add more widgets below if needed
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// To run the page, you can set it as the home widget in your main.dart
void main() {
  runApp(MaterialApp(
    home: LineChartPage(),
  ));
}
