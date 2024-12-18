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

    // เริ่มอนิเมชันเมื่อเริ่มต้น
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ฟังก์ชันเริ่มอนิเมชัน
  void _startAnimation() {
    setState(() {
      isMovedUp = true;
      _controller.forward(); // เลื่อนไปข้างบน
    });

    // หน่วงเวลา 2 วินาทีหลังจากที่กล่องเลื่อนไปข้างบนแล้ว
    Future.delayed(Duration(seconds: 2), () {
      // เมื่อเลื่อนเสร็จแล้ว ให้เลื่อนกลับมาที่เดิม
      setState(() {
        isMovedUp = false;
        _controller.reverse(); // เลื่อนไปข้างล่าง
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('อนิเมชันเลื่อนกล่องขึ้นและลง')),
        body: Center(
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
    );
  }
}
