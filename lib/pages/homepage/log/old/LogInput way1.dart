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
      height: 85, // Increased height to accommodate the date
      decoration: BoxDecoration(
        // color: Colors.lightBlue[50],  เพิ่มสีพื้นหลังที่นี่

        border: Border.all(color: Colors.blueGrey[100]!, width: 2), // Border
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0), // เพิ่ม margin ซ้ายขวา

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          Container(
            padding: EdgeInsets.only(right: 16.0), // Padding for image
            child: Image.asset(
              image,
              height: 70,
            ),
          ),

          Container(
            /*color: const Color.fromARGB(255, 38, 95, 138),*/
            padding:
                EdgeInsets.only(left: 8.0), // Optional: Add padding if needed
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
          // Text and state/money in one group
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 24.0), // เพิ่มความห่างจากด้านขวา
              /* color: const Color.fromARGB(
                        255, 53, 155, 223), // ใส่สีพื้นหลังให้กับ Column*/

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(textmoney,
                      style: TextStyle(fontSize: 18, color: Colors.black)),
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
    );
  }
}

class MyFlexLayout extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      'image': 'assets/images/input_1.png',
      'textA': 'Add Nike',
      'textTime': '9/6/2024',
      'textstate': 'Complete',
      'textmoney': '987',
    },
    {
      'image': 'assets/images/input_11.png',
      'textA': 'Sell Coke',
      'textTime': '9/6/2024',
      'textstate': 'Cancel',
      'textmoney': '207',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Group data by date
    Map<String, List<Map<String, String>>> groupedData = {};
    for (var item in data) {
      groupedData.putIfAbsent(item['textTime']!, () => []).add(item);
    }

    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: ListView.builder(
        itemCount: groupedData.length,
        itemBuilder: (context, index) {
          String date = groupedData.keys.elementAt(index);
          List<Map<String, String>> items = groupedData[date]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display date as a header
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // Display the items for that date
              for (var item in items)
                Column(
                  children: [
                    InfoContainer(
                      image: item['image']!,
                      textA: item['textA']!,
                      textB: item['textTime']!,
                      textstate: item['textstate']!,
                      textmoney: item['textmoney']!,
                    ),
                    SizedBox(height: 10), // Add space between InfoContainers
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
