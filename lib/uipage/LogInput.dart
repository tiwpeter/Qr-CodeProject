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
      decoration: BoxDecoration(
        color: Colors.blueGrey[50], // สีพื้นหลัง
        border: Border.all(color: Colors.blueGrey[100]!, width: 2), // กรอบ
      ),
      width: double.infinity,
      height: 90,
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // เปลี่ยนเป็น start เพื่อจัดเรียงที่จุดเริ่มต้น
        children: [
          // รูปภาพ
          Container(
            padding: EdgeInsets.only(right: 16.0), // เพิ่มระยะห่างทางด้านขวาของรูปภาพ
            child: Image.asset(
              image,
              height: 70,
            ),
          ),
          // ข้อความ
          Container(
            padding: EdgeInsets.only(right: 40.0), // เพิ่มระยะห่างทางด้านขวาของข้อความ
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, // เพื่อจัดข้อความให้เริ่มที่ด้านซ้าย
              children: [
                Text(textA, style: TextStyle(fontSize: 18, color: Colors.black)),
                Text(textB, style: TextStyle(fontSize: 18, color: Colors.black)),
              ],
            ),
          ),
          // ส่วนที่สาม
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text10, style: TextStyle(fontSize: 18, color: Colors.black)),
                SizedBox(width: 10), // เพิ่มระยะห่างระหว่างข้อความและไอคอน
                Image.asset(
                  'assets/images/configuration_1.png',
                  height: 28,
                ),
                SizedBox(width: 10),
                Text(text10, style: TextStyle(fontSize: 18, color: Colors.black)),
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
      padding: EdgeInsets.only(top: 0), // ปรับให้ช่องว่างด้านบนตามความสูงของ AppBar
      child: Column(
        children: [
          InfoContainer(
            image: 'assets/images/input_1.png',
            textA: 'A',
            textB: '9/6/2024',
            text10: '10',
          ),
          InfoContainer(
            image: 'assets/images/input_11.png',
            textA: 'A',
            textB: '9/6/2024',
            text10: '10',
          ),
        ],
      ),
    );
  }
}
