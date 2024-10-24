import 'package:flutter/material.dart';
import 'line_chart_card.dart'; // Import the LineChartCard you created

class LineChartPage extends StatefulWidget {
  const LineChartPage({super.key});

  @override
  _LineChartPageState createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  String _selectedPeriod = '1m'; // Default to 1 month

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 100,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF0080F6),
                          // border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icon/pie-chart.png',
                              width: 20, // Adjust the width as needed
                              height: 20, // Adjust the height as needed
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '128',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Product In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF00B2EB),
                          //border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icon/pie-chart2.png',
                              width: 20, // Adjust the width as needed
                              height: 20, // Adjust the height as needed
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '2,350',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Product Out',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['1m', '2m', '3m', '6m', '1y'].map((period) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedPeriod = period;
                    });
                  },
                  child: Text(
                    period,
                    style: TextStyle(
                      color:
                          _selectedPeriod == period ? Colors.blue : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LineChartCard(
                        selectedPeriod:
                            _selectedPeriod), // Pass the selected period
                    const SizedBox(height: 20),
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
