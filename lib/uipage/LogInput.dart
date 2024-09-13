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
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // กล่องแรกที่มีข้อความ A และ B เรียงกันในแนวนอน
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('A', style: TextStyle(fontSize: 20)),
                Text('B', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          SizedBox(width: 10), // ระยะห่างระหว่างกล่อง
          // กล่องที่สองมีข้อความ 10 และ 10 เรียงกันในแนวนอน
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('10', style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // ระยะห่างระหว่างข้อความ 10
                Text('10', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
