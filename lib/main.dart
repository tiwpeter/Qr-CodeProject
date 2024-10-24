import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('เด้งกล่อง')),
        body: BouncingBoxExample(),
      ),
    );
  }
}

class BouncingBoxExample extends StatefulWidget {
  @override
  _BouncingBoxExampleState createState() => _BouncingBoxExampleState();
}

class _BouncingBoxExampleState extends State<BouncingBoxExample> {
  bool _isSmall = false;

  void _toggleSize() {
    setState(() {
      _isSmall = !_isSmall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _toggleSize,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: _isSmall ? 100 : 200, // ขนาดกล่อง
          height: _isSmall ? 100 : 200,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(_isSmall ? 10 : 0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: _isSmall ? 0 : 10,
                offset: Offset(0, _isSmall ? 0 : 5),
              ),
            ],
          ),
          curve: Curves.bounceInOut, // เอฟเฟกต์เด้ง
        ),
      ),
    );
  }
}
