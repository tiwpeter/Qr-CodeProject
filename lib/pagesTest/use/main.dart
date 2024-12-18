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
  double _left = 0; // เริ่มต้นที่ตำแหน่งซ้ายสุด
  double _top = 0; // เริ่มต้นที่ตำแหน่งบนสุด
  double _width = 100; // ขนาดเริ่มต้นของกล่อง
  double _height = 100; // ขนาดเริ่มต้นของกล่อง

  void _moveAndResizeBox() {
    setState(() {
      final screenWidth =
          MediaQuery.of(context).size.width; // ความกว้างของหน้าจอ
      final screenHeight =
          MediaQuery.of(context).size.height; // ความสูงของหน้าจอ

      // คำนวณตำแหน่ง 50% ของความกว้างหน้าจอ
      _left = _left == 0
          ? screenWidth * 0.5 - _width / 2
          : 0; // ปรับตำแหน่งให้ไม่เกินขอบ
      _top = _top == 0
          ? screenHeight * 0.5 - _height / 2
          : 0; // ปรับตำแหน่งให้ไม่เกินขอบ

      // เปลี่ยนขนาดของกล่อง (ทำให้ขนาดเหมาะสมกับหน้าจอ)
      _width = _width == 100
          ? screenWidth * 0.5
          : 100; // ขยายขนาดกล่องเป็น 50% ของหน้าจอ
      _height = _height == 100
          ? screenHeight * 0.3
          : 100; // ขยายขนาดกล่องเป็น 30% ของหน้าจอ
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smooth Box Movement and Resize")),
      body: GestureDetector(
        onTap: _moveAndResizeBox, // เมื่อคลิกจะเรียกฟังก์ชั่น _moveAndResizeBox
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(seconds: 1), // ระยะเวลาของการเคลื่อนที่
              left: _left,
              top: _top,
              child: AnimatedContainer(
                duration: Duration(seconds: 1), // ระยะเวลาของการเปลี่ยนขนาด
                width: _width,
                height: _height,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
