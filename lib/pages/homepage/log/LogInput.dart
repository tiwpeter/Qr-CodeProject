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
    // เพิ่ม return ที่นี่
    return Container(
      width: double.infinity,
      height: 150, // เพิ่มความสูงเพื่อรองรับวันที่
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // วันที่แสดงใน Column
          Text(
            textB, // วันที่
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          //SizedBox(height: 8), // ระยะห่างระหว่างวันที่และข้อมูลหลัก

          // ข้อมูลหลักแสดงใน Row
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blueGrey[50], // สีพื้นหลัง
              border:
                  Border.all(color: Colors.blueGrey[100]!, width: 2), // กรอบ
            ),
            padding: EdgeInsets.all(8), // เพิ่ม padding รอบ ๆ ทั้งหมด
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // รูปภาพ
                Container(
                  padding: EdgeInsets.only(
                      right: 16.0), // เพิ่มระยะห่างทางด้านขวาของรูปภาพ
                  child: Image.asset(
                    image,
                    height: 70,
                  ),
                ),
                // ข้อความ
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // จัดข้อความให้เริ่มที่ด้านซ้าย
                  children: [
                    Text(
                      textA,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
                // ส่วนที่สาม
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${textmoney}',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 5), // เพิ่มระยะห่าง
                    Text(
                      textstate,
                      style: TextStyle(
                        fontSize: 18,
                        color: textstate == 'Cancel'
                            ? Colors.red
                            : Colors.green, // เปลี่ยนสีตามสถานะ
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
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
          EdgeInsets.only(top: 0), // ปรับให้ช่องว่างด้านบนตามความสูงของ AppBar
      child: Column(
        children: [
          InfoContainer(
            image: 'assets/images/input_1.png',
            textA: 'Add Nike',
            textB: '9/6/2024',
            textstate: 'Complie',
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
