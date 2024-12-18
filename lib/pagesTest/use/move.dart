import 'package:flutter/material.dart';

void main() {
  runApp(MyPageQr2());
}

class MyPageQr2 extends StatefulWidget {
  @override
  _MyPageQr2State createState() => _MyPageQr2State();
}

class _MyPageQr2State extends State<MyPageQr2> {
  double _left = 20; // ตำแหน่งเริ่มต้นของกล่องสีส้ม
  double _top = 100; // ตำแหน่งเริ่มต้นของกล่องสีส้ม

  // ฟังก์ชันที่จะเปลี่ยนตำแหน่งกล่องเมื่อกดปุ่ม
  void _moveBox() {
    setState(() {
      // เปลี่ยนตำแหน่งกล่องทุกครั้งที่กดปุ่ม
      _left = _left == 20 ? 150 : 20; // สลับตำแหน่งจาก 20 ไป 150
      _top = _top == 100 ? 300 : 100; // สลับตำแหน่งจาก 100 ไป 300
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Animation with Positioned')),
        body: Stack(
          children: [
            // กล่องสีฟ้าที่เต็มหน้าจอ
            Container(
              color: Colors.blue, // สีของกล่องใหญ่
              width: double.infinity, // เต็มความกว้าง
              height: double.infinity, // เต็มความสูง
            ),
            // กล่องสีส้มที่ถูกจัดตำแหน่งโดยใช้ AnimatedPositioned
            AnimatedPositioned(
              left: _left, // ค่าเริ่มต้นและค่าปัจจุบันของตำแหน่งซ้าย
              top: _top, // ค่าเริ่มต้นและค่าปัจจุบันของตำแหน่งบน
              duration: Duration(seconds: 1), // ระยะเวลาในการเคลื่อนไหว
              child: Container(
                color: Colors.orange, // สีของกล่องใน
                width: 200, // ความกว้างของกล่องใน
                height: 200, // ความสูงของกล่องใน
              ),
            ),
            // ปุ่มที่เมื่อกดจะทำการเลื่อนกล่อง
            Positioned(
              bottom: 50, // วางปุ่มที่ด้านล่าง
              left: 50, // วางปุ่มห่างจากขอบซ้าย
              child: ElevatedButton(
                onPressed: _moveBox, // เมื่อกดปุ่มจะเรียกฟังก์ชัน _moveBox
                child: Text('Move Box'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
