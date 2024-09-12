import 'package:flutter/material.dart';

void main() {
  runApp(CertTest());
}

class CertTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // First Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // CustomTextFormField
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Log',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: TextEditingController(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12), // Space between elements
                  // Inner Row
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // View One
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          padding: EdgeInsets.all(8.0),
                       child: Image.asset(
        'assets/images/input_1.png',
        height: 70, // ปรับขนาดตามที่ต้องการ
      ),
                        ),
                        SizedBox(width: 8),
                        // Nested Rows and Columns
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Column with texts and rows
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bankok',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '9/6/2024',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'Bankok',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                               
                              ],
                            ),
                            SizedBox(width: 20),
                            // Row with Stack and Image
                            Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Stack(
      alignment: Alignment.center,
      children: [
        Text(
          '10',
          style: TextStyle(fontSize: 14, color: Colors.green),
        ),
      ],
    ),
    SizedBox(width: 24),
                                Stack(
  alignment: Alignment.center,
  children: [
    Image.asset(
      'assets/images/configuration_1.png',
      height: 14,
    ),
  ],
),
                              SizedBox(width: 24),
Stack(
  alignment: Alignment.center,
  children: [
    Text(
      '10',
      style: TextStyle(fontSize: 14, color: Colors.red),
    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Second Row
              
            ],
          ),
        ),
      ),
    );
  }
}
