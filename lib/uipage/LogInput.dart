import 'package:flutter/material.dart';

void main() {
  runApp(LogInput());
}

class LogInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flex Layout Example')),
        body: MyFlexLayout(),
      ),
    );
  }
}

class MyFlexLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: kToolbarHeight), // ปรับให้ช่องว่างด้านบนตามความสูงของ AppBar
      child: Column(
        children: [
          // กล่องแรก
          Container(
            color: const Color.fromARGB(255, 165, 165, 165), // สีพื้นหลังของกล่อง
            width: 500, // ความกว้างของกล่อง
            height: 90, // ความสูงของกล่อง
            padding: EdgeInsets.all(8.0), // ระยะห่างภายใน
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10), // ระยะห่างระหว่างกล่อง
                // กล่องที่มีภาพ
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/input_1.png',
                    height: 70, // กำหนดความสูงของภาพ
                  ),
                ),
                // กล่องที่มีข้อความ A และ B เรียงกันในแนวนอน
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('A', style: TextStyle(fontSize: 18, color: Colors.white)), // ขนาดข้อความ
                      Text('9/6/2024', style: TextStyle(fontSize: 18, color: Colors.white)), // ขนาดข้อความ
                    ],
                  ),
                ),
                SizedBox(width: 10), // ระยะห่างระหว่างกล่อง
                // กล่องที่มีข้อความ 10 และ 10 เรียงกันในแนวนอน
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('10', style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(width: 10), // ระยะห่างระหว่างข้อความ 10
                      Image.asset(
                        'assets/images/configuration_1.png',
                        height: 28, // กำหนดความสูงของภาพ
                      ),
                      SizedBox(width: 10), // ระยะห่างระหว่างภาพและข้อความ 10
                      Text('10', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10), // ระยะห่างระหว่างกล่อง
          // กล่องใหม่
          Container(
            color: const Color.fromARGB(255, 165, 165, 165), // สีพื้นหลังของกล่อง
            width: 500, // ความกว้างของกล่อง
            height: 90, // ความสูงของกล่อง
            padding: EdgeInsets.all(8.0), // ระยะห่างภายใน
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10), // ระยะห่างระหว่างกล่อง
                // กล่องที่มีภาพ
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/input_1.png',
                    height: 70, // กำหนดความสูงของภาพ
                  ),
                ),
                // กล่องที่มีข้อความ A และ B เรียงกันในแนวนอน
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('A', style: TextStyle(fontSize: 18, color: Colors.white)), // ขนาดข้อความ
                      Text('9/6/2024', style: TextStyle(fontSize: 18, color: Colors.white)), // ขนาดข้อความ
                    ],
                  ),
                ),
                SizedBox(width: 10), // ระยะห่างระหว่างกล่อง
                // กล่องที่มีข้อความ 10 และ 10 เรียงกันในแนวนอน
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('10', style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(width: 10), // ระยะห่างระหว่างข้อความ 10
                      Image.asset(
                        'assets/images/configuration_1.png',
                        height: 28, // กำหนดความสูงของภาพ
                      ),
                      SizedBox(width: 10), // ระยะห่างระหว่างภาพและข้อความ 10
                      Text('10', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
