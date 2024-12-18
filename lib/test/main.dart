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
  double _left = 0;
  double _top = 0;
  double _width = 100; // ขนาดเริ่มต้นของกล่อง
  double _height = 100; // ขนาดเริ่มต้นของกล่อง

  void _moveAndResizeBox() {
    setState(() {
      _left = _left == 0 ? 100 : 0; // เปลี่ยนตำแหน่งของกล่อง
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
