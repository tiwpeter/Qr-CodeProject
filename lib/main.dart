import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('AnimatedSwitcher Example')),
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
                    child: Text('First Widget',
                        style: TextStyle(color: Colors.white)),
                  )
                : Container(
                    key: ValueKey(2),
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text('Second Widget',
                        style: TextStyle(color: Colors.white)),
                  ),
            transitionBuilder: (Widget child, Animation<double> animation) {
              // เอฟเฟกต์การย่อลงและเลื่อน
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 0.5), // เริ่มจากด้านล่าง
                  end: Offset(0, 0),
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.8, // ย่อขนาดเริ่มต้น
                      end: 1.0, // ขยายกลับไปขนาดเดิม
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    )),
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
