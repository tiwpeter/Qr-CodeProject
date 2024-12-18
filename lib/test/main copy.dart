import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SmoothMoveAndResizeDemo(),
    );
  }
}

class SmoothMoveAndResizeDemo extends StatefulWidget {
  @override
  _SmoothMoveAndResizeDemoState createState() =>
      _SmoothMoveAndResizeDemoState();
}

class _SmoothMoveAndResizeDemoState extends State<SmoothMoveAndResizeDemo> {
  double _top = 0;
  double _width = 100; // ขนาดเริ่มต้นของกล่อง
  double _height = 100; // ขนาดเริ่มต้นของกล่อง

  void _moveAndResizeBox() {
    setState(() {
      _top = _top == 0 ? 300 : 0; // เปลี่ยนตำแหน่งของกล่อง
      _width = _width == 100 ? 200 : 100; // เปลี่ยนขนาดของกล่อง
      _height = _height == 100 ? 200 : 100; // เปลี่ยนขนาดของกล่อง
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smooth Box Movement and Resize")),
      body: GestureDetector(
        onTap: _moveAndResizeBox, // เมื่อคลิกจะเรียกฟังก์ชั่น _moveAndResizeBox
        child: Container(
          color: Colors.grey[200], // สีพื้นหลังของ container
          child: Stack(
            children: [
              // กล่องที่เคลื่อนไหว
              AnimatedPositioned(
                duration: Duration(seconds: 1), // ระยะเวลาของการเคลื่อนที่
                top: _top,
                left: 0, // กำหนดตำแหน่งเริ่มต้นที่ด้านซ้าย
                right: 0, // กำหนดตำแหน่งเริ่มต้นที่ด้านขวา
                child: Align(
                  alignment:
                      Alignment.center, // จัดตำแหน่งให้อยู่กึ่งกลางในแนวนอน
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1), // ระยะเวลาของการเปลี่ยนขนาด
                    width: _width,
                    height: _height,
                    color: Colors.blue,
                  ),
                ),
              ),

              // กล่องที่สองอยู่กลางในแนวนอนโดยไม่ใช้ Positioned
              Align(
                alignment: Alignment.center, // จัดให้อยู่กลางในแนวนอน
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.red, // สีของกล่องที่สอง
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
