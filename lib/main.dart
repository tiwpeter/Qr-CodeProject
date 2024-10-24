import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('AnimatedSwitcher')),
        body: AnimatedSwitcherExample(),
      ),
    );
  }
}

class AnimatedSwitcherExample extends StatefulWidget {
  @override
  _AnimatedSwitcherExampleState createState() =>
      _AnimatedSwitcherExampleState();
}

class _AnimatedSwitcherExampleState extends State<AnimatedSwitcherExample> {
  bool _showFirst = true;

  void _toggleWidget() {
    setState(() {
      _showFirst = !_showFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: _showFirst
                ? Container(
                    key: ValueKey(1),
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text('First', style: TextStyle(color: Colors.white)),
                  )
                : Container(
                    key: ValueKey(2),
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child:
                        Text('Second', style: TextStyle(color: Colors.white)),
                  ),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.5), // เริ่มจากด้านล่าง
                    end: Offset(0, -1), // เลื่อนขึ้นไปหาตำแหน่ง AppBar
                  ).animate(animation),
                  child: ScaleTransition(
                    scale:
                        Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                    child: child,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _toggleWidget,
            child: Text('Toggle'),
          ),
        ],
      ),
    );
  }
}
