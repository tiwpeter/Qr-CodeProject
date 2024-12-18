import 'package:flutter/material.dart';

void main() {
  runApp(MyPageQr2());
}

class MyPageQr2 extends StatefulWidget {
  @override
  _MyPageQr2State createState() => _MyPageQr2State();
}

class _MyPageQr2State extends State<MyPageQr2> with TickerProviderStateMixin {
  bool _isExpanded = false; // กำหนดสถานะการขยายกล่อง
  double _topPosition = 0.0; // ตำแหน่งเริ่มต้นของกล่อง
  double _containerHeight = 100.0; // ความสูงของกล่อง
  double _imageSize = 50.0; // ขนาดของรูป
  double _fontSizeTitle = 16.0; // ขนาดของข้อความหัวข้อ
  double _fontSizeSubtitle = 14.0; // ขนาดของข้อความรอง
  bool _isVisible = false; // กำหนดสถานะของการแสดงกล่อง (เริ่มต้นคือซ่อน)

  @override
  void initState() {
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible; // สลับสถานะการแสดงกล่อง
      if (_isVisible) {
        // เมื่อกล่องแสดง ให้ทำการขยายและอนิเมชั่น
        _topPosition = 100.0;
        _containerHeight = 150.0;
        _imageSize = 80.0;
        _fontSizeTitle = 20.0;
        _fontSizeSubtitle = 16.0;
      } else {
        // เมื่อกล่องซ่อน ให้คืนค่ากลับ
        _topPosition = 0.0;
        _containerHeight = 100.0;
        _imageSize = 10.0;
        _fontSizeTitle = 16.0;
        _fontSizeSubtitle = 14.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("My Page QR")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // ปุ่มคลิกเพื่อแสดง/ซ่อนกล่อง
              ElevatedButton(
                onPressed: _toggleVisibility,
                child: Text(_isVisible ? "ซ่อนกล่อง" : "แสดงกล่อง"),
              ),
              SizedBox(height: 20),
              // การอนิเมชั่นการแสดง/ซ่อนกล่อง
              Stack(
                children: [
                  AnimatedOpacity(
                    opacity: _isVisible ? 1.0 : 0.0, // ความโปร่งใสของกล่อง
                    duration: Duration(milliseconds: 200), // ปรับให้เร็วขึ้น
                    child: AnimatedPositioned(
                      duration: Duration(milliseconds: 200), // ปรับให้เร็วขึ้น
                      curve: Curves.easeOut,
                      top: _topPosition, // เลื่อนกล่องขึ้นหรือลง
                      left: 0,
                      right: 0,
                      child: AnimatedContainer(
                        duration:
                            Duration(milliseconds: 200), // ปรับให้เร็วขึ้น
                        curve: Curves.easeInOut,
                        height: _containerHeight, // ความสูงของกล่อง
                        color: Colors.white,
                        padding: EdgeInsets.all(10), // เพิ่ม padding ภายในกล่อง
                        margin:
                            EdgeInsets.only(bottom: 15), // ช่องว่างระหว่างกล่อง
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // จัดข้อความให้ชิดซ้าย
                          children: [
                            // รูปภาพทางซ้าย
                            AnimatedContainer(
                              duration: Duration(
                                  milliseconds: 200), // ปรับให้เร็วขึ้น
                              width: _imageSize, // ขยายขนาดของรูป
                              height: _imageSize,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/Shose.jpg'), // ใส่ที่อยู่ของรูปภาพ
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.circular(8.0), // ขอบกลม
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
