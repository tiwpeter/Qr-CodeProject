import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(MyPageQr2());
}

class MyPageQr2 extends StatefulWidget {
  @override
  _MyPageQr2State createState() => _MyPageQr2State();
}

class _MyPageQr2State extends State<MyPageQr2> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isMovedUp = false; // ใช้เพื่อตรวจสอบว่าอนิเมชันจะไปทางไหน

  @override
  void initState() {
    super.initState();
    // สร้าง AnimationController ที่ควบคุมอนิเมชัน
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // สร้าง Tween animation เพื่อให้กล่องเลื่อนไปยังตำแหน่งใหม่
    _animation = Tween<double>(begin: 200.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ฟังก์ชันที่สลับสถานะการเลื่อนขึ้นลง
  void _toggleAnimation() {
    setState(() {
      isMovedUp = !isMovedUp;
      // ทำให้ Animation เคลื่อนไหวไปทางตำแหน่งเริ่มต้นหรือจุดสุดท้าย
      if (isMovedUp) {
        _controller.forward(); // เลื่อนไปข้างบน
      } else {
        _controller.reverse(); // เลื่อนไปข้างล่าง
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('อนิเมชันเลื่อนกล่องขึ้นและลง')),
        body: Center(
          child: GestureDetector(
            onTap: _toggleAnimation, // เมื่อคลิกจะสลับตำแหน่งกล่อง
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: [
                    Positioned(
                      top: _animation.value,
                      left: 100.0,
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            'ลากกล่องขึ้นลง',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
