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
                      hintText: 'ตระกร้า',
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
                          height: 70,
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'View One',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                      '29',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'บาท',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Text(
                                  '29',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(width: 50),
                            // Row with Stack and Image
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/delete_1.png',
                                      height: 14,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 24),
                                Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(width: 24),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/add_11.png',
                                      height: 14,
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
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'bankok_two',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'ยังไม่รวมส่วนลด',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
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
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 26),
                          Text(
                            'บาท',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '29',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 24),
                          Text(
                            'บาท',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
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
