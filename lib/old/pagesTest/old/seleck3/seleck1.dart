import 'package:flutter/material.dart';
import 'dart:ui'; // สำหรับ BackdropFilter

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPageQr2(),
    );
  }
}

class MyPageQr2 extends StatefulWidget {
  @override
  _MyPageQr2State createState() => _MyPageQr2State();
}

class _MyPageQr2State extends State<MyPageQr2> {
  int _selectedBox = 0; // ตัวแปรเก็บหมายเลขกล่องที่เลือก

  void _changeBox() {
    setState(() {
      _selectedBox = (_selectedBox + 1) % 3; // เลื่อนกล่องไปข้างหน้า
    });
  }

  Widget _buildBox(int index) {
    bool isSelected = _selectedBox == index;
    double size = isSelected ? 120 : 80; // ปรับขนาดกล่องที่เลือกและไม่ได้เลือก

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBox = index; // เมื่อคลิกกล่อง เลือกกล่องนั้น
        });
      },
      child: AnimatedContainer(
        width: size,
        height: size,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (index == 0
                  ? Colors.red
                  : index == 1
                      ? Colors.green
                      : Colors.blue)
              : Colors.grey.withOpacity(0.5), // เบลอกล่องที่ไม่ได้เลือก
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 4),
                      blurRadius: 8)
                ]
              : [],
        ),
        duration: Duration(milliseconds: 300),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!isSelected) // เบลอกรณีที่ไม่ได้เลือก
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(color: Colors.transparent),
              ),
            Text(
              'กล่อง ${index + 1}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isSelected ? 18 : 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เลือกกล่อง')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3, (index) => _buildBox(index)), // สร้างกล่อง 3 อัน
            ),
            SizedBox(height: 20),
            // ปุ่มที่จะใช้ในการเลื่อนกล่อง
            ElevatedButton(
              onPressed: _changeBox,
              child: Text('เลื่อนกล่อง'),
            ),
          ],
        ),
      ),
    );
  }
}
