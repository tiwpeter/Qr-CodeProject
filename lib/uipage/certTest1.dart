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
                      hintText: 'Your hint text here', // Customize as needed
                    ),
                    controller: TextEditingController(),
                    textAlign: TextAlign.center,
                  ),
                  // Inner Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // View One
                      Container(
                        alignment: Alignment.center,
                        height: 70,
                        child: Text('View One'), // Customize as needed
                      ),
                      SizedBox(width: 8), // Adjust spacing as needed
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
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '29',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'บาท',
                                    textAlign: TextAlign.center, // Center alignment for text
                                  ),
                                ],
                              ),
                              Text(
                                '29',
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          // Row with Stack and Image
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/delete_1.png',
                                    height: 14,
                                  ),
                                ],
                              ),
                              SizedBox(width: 24),
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 4),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/add_11.png',
                                    height: 38,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Second Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Column with bankok text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'bankok_one',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'bankok_two',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'ยังไม่รวมส่วนลด',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  // Column with amount texts
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '32',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 26),
                          Text(
                            'บาท',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '29',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 24),
                          Text(
                            'บาท',
                            textAlign: TextAlign.center,
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
      ),
    );
  }
}
