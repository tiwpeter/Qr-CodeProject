import 'package:flutter/material.dart';

void main() {
  runApp(LogInput());
}

class LogInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flex Layout Example')),
        body: MyFlexLayout(),
      ),
    );
  }
}

class MyFlexLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.grey[800], // สีพื้นหลังขาวเข้ม
        width: 380, // กำหนดความกว้างของกล่องหลัก
        height: 100, // เพิ่มความสูงของกล่องหลัก
        padding: EdgeInsets.all(8.0), // ระยะห่างภายใน
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // กล่องแรกที่มีข้อความ A และ B เรียงกันในแนวนอน
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('A', style: TextStyle(fontSize: 18, color: Colors.white)), // ลดขนาดข้อความ
                  Text('B', style: TextStyle(fontSize: 18, color: Colors.white)), // ลดขนาดข้อความ
                ],
              ),
            ),
            SizedBox(width: 10), // ระยะห่างระหว่างกล่อง
            // กล่องที่สองมีข้อความ 10 และ 10 เรียงกันในแนวนอน
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('10', style: TextStyle(fontSize: 18, color: Colors.white)), // ลดขนาดข้อความ
                  SizedBox(width: 10), // ระยะห่างระหว่างข้อความ 10
                  Text('10', style: TextStyle(fontSize: 18, color: Colors.white)), // ลดขนาดข้อความ
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
