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
            Container(
              color: Colors.red,
              height: 100, // Adjust height as needed
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Space them evenly
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(
                            8.0), // Inner padding for the content
                        decoration: BoxDecoration(
                          color: Colors
                              .red[700], // Background color for the container
                          border: Border.all(
                              color: Colors.white,
                              width: 2), // Border properties
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the left
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total Product',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                                height:
                                    4), // Space between 'Profit' and '2,350'
                            Text(
                              '128',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight
                                    .bold, // Add this line for bold text
                              ),
                            ),
                            const SizedBox(
                                height:
                                    6), // Space between 'Profit' and '2,350'
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .blue, // Change background color to blue
                                    borderRadius: BorderRadius.circular(
                                        50.0), // Make it oval
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0), // Add some padding
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // Minimize the size of the row
                                    children: [
                                      Image.asset(
                                        'assets/icon/up-arrowStock.png', // Replace with your image path
                                        width: 8,
                                        height: 8,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                          width:
                                              4), // Space between the image and text
                                      Text(
                                        '+8.00%',
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
                    const SizedBox(
                        width: 16), // Optional space between the two containers
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(
                            8.0), // Inner padding for the content
                        decoration: BoxDecoration(
                          color: Colors
                              .red[700], // Background color for the container
                          border: Border.all(
                              color: Colors.white,
                              width: 2), // Border properties
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the left
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Profit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                                height:
                                    4), // Space between 'Profit' and '2,350'
                            Text(
                              '2,350',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight
                                    .bold, // Add this line for bold text
                              ),
                            ),
                            const SizedBox(
                                height:
                                    6), // Space between 'Profit' and '2,350'
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .blue, // Change background color to blue
                                    borderRadius: BorderRadius.circular(
                                        50.0), // Make it oval
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0), // Add some padding
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // Minimize the size of the row
                                    children: [
                                      Image.asset(
                                        'assets/icon/up-arrowStock.png', // Replace with your image path
                                        width: 8,
                                        height: 8,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                          width:
                                              4), // Space between the image and text
                                      Text(
                                        '+2.34%',
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
            const SizedBox(
                height: 20), // Space between the header and the chart
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
