import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('สองกล่อง')),
        body: AnimatedBoxExample(),
      ),
    );
  }
}

class AnimatedBoxExample extends StatefulWidget {
  @override
  _AnimatedBoxExampleState createState() => _AnimatedBoxExampleState();
}

class _AnimatedBoxExampleState extends State<AnimatedBoxExample> {
  bool _isMoved = false;

  void _togglePosition() {
    setState(() {
      _isMoved = !_isMoved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          top: _isMoved ? 50 : 0, // เลื่อนกล่องแดงขึ้น
          right: _isMoved ? 0 : 50, // เลื่อนกล่องแดงไปทางขวา
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red, // กล่องแดง
          ),
        ),
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          bottom: _isMoved ? 50 : 0, // เลื่อนกล่องฟ้าขึ้น
          left: _isMoved ? 0 : 50, // เลื่อนกล่องฟ้าไปทางซ้าย
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue, // กล่องฟ้า
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: ElevatedButton(
            onPressed: _togglePosition,
            child: Text('Toggle Position'),
          ),
        ),
      ],
    );
  }
}
