import 'package:flutter/material.dart';
import 'package:poject_qr/pages/homepage/log/HomeAppBar.dart'; // ตรวจสอบให้แน่ใจว่าเส้นทางของ HomeAppBar ถูกต้อง

void main() {
  runApp(LogInput());
}

class LogInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: HomeAppBar(),
        body: MyFlexLayout(),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String image;
  final String textA;
  final String textB;
  final String textstate;
  final String textmoney;

  InfoContainer({
    required this.image,
    required this.textA,
    required this.textB,
    required this.textstate,
    required this.textmoney,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150, // Increased height to accommodate the date
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textB, // Date
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          // Main content displayed in Row
          Container(
            height: 100,
            decoration: BoxDecoration(
              /* color: Colors.blueGrey[50], // Background color*/
              border:
                  Border.all(color: Colors.blueGrey[100]!, width: 2), // Border
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                // Image
                Container(
                  /* color: const Color.fromARGB(
                      255, 22, 26, 29), // ใส่สีพื้นหลังให้กับ Column*/
                  padding: EdgeInsets.only(right: 16.0), // Padding for image
                  child: Image.asset(
                    image,
                    height: 70,
                  ),
                ),
                // Text
                Container(
                  /*color: const Color.fromARGB(255, 38, 95, 138),*/
                  padding: EdgeInsets.only(
                      left: 8.0), // Optional: Add padding if needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to left
                    children: [
                      Text(
                        textA,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),

                // Spacer or Expanded to push this part to the right
                // Right section (state and money)
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 24.0), // เพิ่มความห่างจากด้านขวา
                    /* color: const Color.fromARGB(
                        255, 53, 155, 223), // ใส่สีพื้นหลังให้กับ Column*/

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(textmoney,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                        SizedBox(width: 10),
                        Text(
                          textstate,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey), // Adjust to another color
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyFlexLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 0), // Adjust top padding based on AppBar height
      child: Column(
        children: [
          InfoContainer(
            image: 'assets/images/input_1.png',
            textA: 'Add Nike',
            textB: '9/6/2024',
            textstate: 'Complete',
            textmoney: '987',
          ),
          InfoContainer(
            image: 'assets/images/input_11.png',
            textA: 'Sell Coke',
            textB: '9/6/2024',
            textstate: 'Cancel',
            textmoney: '207',
          ),
        ],
      ),
    );
  }
}
