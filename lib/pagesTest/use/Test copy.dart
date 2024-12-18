import 'package:flutter/material.dart';

void main() {
  runApp(MyPageQr2());
}

class MyPageQr2 extends StatefulWidget {
  @override
  _MyPageQr2State createState() => _MyPageQr2State();
}

class _MyPageQr2State extends State<MyPageQr2> with TickerProviderStateMixin {
  double _topPosition = 100.0; // ตำแหน่งเริ่มต้นของกล่อง
  double _leftPosition = 0.0; // ตำแหน่งซ้ายของกล่อง
  double _containerHeight = 150.0; // ความสูงของกล่อง
  double _imageSize = 80.0; // ขนาดของรูป
  double _imageLeftPosition = 0.0; // ตำแหน่งซ้ายของรูป
  bool _isLarge = false; // สถานะของปุ่มที่จะเปลี่ยนขนาด

  @override
  void initState() {
    super.initState();
  }

  void _toggleSize() {
    setState(() {
      _isLarge = !_isLarge;
      // ปรับเปลี่ยนขนาดของกล่อง
      _containerHeight = _isLarge ? 250.0 : 150.0;
      _imageSize = _isLarge ? 120.0 : 80.0; // ขนาดของรูป
      _topPosition = _isLarge ? 50.0 : 100.0; // เปลี่ยนตำแหน่งของกล่อง
      // เปลี่ยนตำแหน่งซ้ายหรือขวาของกล่อง
      _leftPosition = _isLarge ? 100.0 : 0.0; // เปลี่ยนตำแหน่งซ้าย
      // ปรับตำแหน่งของรูปภาพให้เคลื่อนที่ตาม
      _imageLeftPosition = _isLarge ? 100.0 : 0.0; // เคลื่อนที่ไปทางขวา
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
              SizedBox(height: 20),
              // เพิ่มปุ่มที่คลิกเพื่อแสดงอนิเมชั่น
              ElevatedButton(
                onPressed: _toggleSize,
                child: Text(_isLarge ? "Shrink Box" : "Expand Box"),
              ),
              SizedBox(height: 20),
              // การอนิเมชั่นการแสดงกล่อง
              Stack(
                children: [
                  AnimatedOpacity(
                    opacity: 1.0, // ตั้งให้กล่องแสดงเสมอ
                    duration: Duration(milliseconds: 200), // ความเร็วในการแสดง
                    child: AnimatedPositioned(
                      duration:
                          Duration(milliseconds: 200), // ความเร็วในการแสดง
                      curve: Curves.easeOut,
                      top: _topPosition, // ตำแหน่งของกล่อง
                      left: _leftPosition, // ตำแหน่งซ้ายของกล่อง
                      right:
                          _isLarge ? 30.0 : 0.0, // หากต้องการตั้งตำแหน่งขวาด้วย
                      child: AnimatedContainer(
                        duration:
                            Duration(milliseconds: 200), // ความเร็วในการแสดง
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
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 200),
                              left: _imageLeftPosition, // เคลื่อนที่ตามตำแหน่ง
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                width: _imageSize, // ขนาดของรูป
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
