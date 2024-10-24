import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSwitcherExample(),
    );
  }
}

class AnimatedSwitcherExample extends StatefulWidget {
  @override
  _AnimatedSwitcherExampleState createState() =>
      _AnimatedSwitcherExampleState();
}

class _AnimatedSwitcherExampleState extends State<AnimatedSwitcherExample> {
  bool _showRedBox = true;

  void _toggleBox() {
    setState(() {
      _showRedBox = !_showRedBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('สองกล่อง')),
      body: GestureDetector(
        onTap: _toggleBox,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              top: _showRedBox ? 0 : 200,
              right: _showRedBox ? 0 : 100,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: _showRedBox
                    ? Container(
                        key: ValueKey('RedBox'),
                        width: 100,
                        height: 100,
                        color: Colors.red, // กล่องแดง
                      )
                    : Container(
                        key: ValueKey('BlueBox'),
                        width: 100,
                        height: 100,
                        color: Colors.blue, // กล่องฟ้า
                      ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue, // กล่องฟ้า
              ),
            ),
          ],
        ),
      ),
    );
  }
}
