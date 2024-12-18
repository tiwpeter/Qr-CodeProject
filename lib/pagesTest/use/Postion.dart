import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(MyPageQr2());
}

class MyPageQr2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("My Page QR")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              // กล่องแรก
              Positioned(
                top: 0, // ตำแหน่งจากบน
                left: 0, // ตำแหน่งจากซ้าย
                right: 0, // ให้เต็มขนาด
                child: Container(
                  color: Colors.white, // กล่องสีขาว
                  padding: EdgeInsets.all(10), // เพิ่ม padding ภายในกล่อง
                  margin: EdgeInsets.only(bottom: 15), // ช่องว่างระหว่างกล่อง
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // จัดข้อความให้ชิดซ้าย
                    children: [
                      // รูปภาพทางซ้าย
                      Container(
                        width: 50, // ขนาดของรูป
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/Shose.jpg'), // ใส่ที่อยู่ของรูปภาพ
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.0), // ขอบกลม
                        ),
                      ),
                      SizedBox(width: 15), // ช่องว่างระหว่างรูปและข้อความ
                      // Column สำหรับข้อความ
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // จัดข้อความให้ชิดซ้าย
                          children: [
                            Text(
                              'ข้อความแรกที่ต้องการแสดง',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5), // ช่องว่างระหว่างข้อความ
                            Text(
                              'ข้อความที่สองที่ต้องการแสดง',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // กล่องแดง
              Positioned(
                top: 50, // ตั้งตำแหน่งจากบน
                left: 50, // ตั้งตำแหน่งจากซ้าย
                child: Container(
                  width: 200, // ความกว้างของกล่อง
                  height: 200, // ความสูงของกล่อง
                  color: Colors.red, // สีของกล่อง
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
