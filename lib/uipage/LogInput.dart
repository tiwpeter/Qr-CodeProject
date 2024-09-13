import 'package:flutter/material.dart';
import 'package:poject_qr/widgets/HomeAppBar.dart'; // ตรวจสอบให้แน่ใจว่าเส้นทางของ HomeAppBar ถูกต้อง

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
  final String text10;

  InfoContainer({
    required this.image,
    required this.textA,
    required this.textB,
    required this.text10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 165, 165, 165),
      width: double.infinity, // ใช้ double.infinity เพื่อให้ขยายเต็มความกว้างของพื้นที่
      height: 90,
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              image,
              height: 70,
            ),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(textA, style: TextStyle(fontSize: 18, color: Colors.white)),
                Text(textB, style: TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text10, style: TextStyle(fontSize: 18, color: Colors.white)),
                SizedBox(width: 10),
                Image.asset(
                  'assets/images/configuration_1.png',
                  height: 28,
                ),
                SizedBox(width: 10),
                Text(text10, style: TextStyle(fontSize: 18, color: Colors.white)),
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
      padding: EdgeInsets.only(top: 5), // ปรับให้ช่องว่างด้านบนตามความสูงของ AppBar
      child: Column(
        children: [
          InfoContainer(
            image: 'assets/images/input_1.png',
            textA: 'A',
            textB: '9/6/2024',
            text10: '10',
          ),
          SizedBox(height: 10),
          InfoContainer(
            image: 'assets/images/input_1.png',
            textA: 'A',
            textB: '9/6/2024',
            text10: '10',
          ),
        ],
      ),
    );
  }
}
