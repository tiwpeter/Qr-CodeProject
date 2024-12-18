import 'package:flutter/material.dart';

void main() {
  runApp(MyPageQr2());
}

class MyPageQr2 extends StatefulWidget {
  @override
  _MyPageQr2State createState() => _MyPageQr2State();
}

class _MyPageQr2State extends State<MyPageQr2> {
  double _topPosition = 100.0; // ตำแหน่งเริ่มต้นของกล่อง (แนวตั้ง)
  double _leftPosition = 50.0; // ตำแหน่งเริ่มต้นของกล่อง (แนวนอน)

  void _moveBox() {
    setState(() {
      // การเปลี่ยนตำแหน่งใหม่ของกล่อง
      _topPosition = _topPosition == 100.0 ? 300.0 : 100.0;
      _leftPosition = _leftPosition == 50.0 ? 200.0 : 50.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Smooth Movement Box")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _moveBox, // เมื่อกดปุ่มจะย้ายกล่อง
                  child: Text("Move Box"),
                ),
                SizedBox(height: 20),
                // การเคลื่อนที่ของกล่อง
                Stack(
                  children: [
                    AnimatedPositioned(
                      duration: Duration(seconds: 2), // ระยะเวลาแอนิเมชั่น
                      curve: Curves.easeInOut, // การเคลื่อนที่ที่สมูท
                      top: _topPosition, // ตำแหน่งแนวตั้ง
                      left: _leftPosition, // ตำแหน่งแนวนอน
                      child: Container(
                        width: 150,
                        height: 150,
                        color: Colors.blue, // สีของกล่อง
                        child: Center(
                          child: Text(
                            "Box",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
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
      ),
    );
  }
}
