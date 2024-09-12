import 'package:flutter/material.dart';

void main() {
  runApp(MyPageQr2());
}

class MyPageQr2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              AppBar(
                toolbarHeight: 72,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'shop_one',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    CustomButton(
                      decoration: BoxDecoration(
                        color: Colors.blue, // Example color, adjust as needed
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'find',
                        style: TextStyle(color: Colors.white), // Ensure text is visible
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 38),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 266,
                        color: Colors.grey[200], // Example color for view_two
                        child: Text('view_two'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 42), // Increased spacing
                            child: Text('Add', style: TextStyle(fontSize: 16)),
                          ),
                          CustomButton(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue), // Example border color
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('sell', style: TextStyle(color: Colors.blue)), // Ensure text is visible
                            alignment: Alignment.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 42), // Increased spacing
                            child: Text('search', style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/icon/add.png', height: 32),
                      ],
                    ),
                    SizedBox(width: 64), // Spacing between images
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/icon/up-selling.png', height: 32),
                      ],
                    ),
                    SizedBox(width: 64), // Spacing between images
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/icon/loupe.png', height: 32),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 84,
                  margin: EdgeInsets.only(top: 78, bottom: 4),
                  color: Colors.grey[300], // Example color for view_one
                  child: Text('view_one'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final BoxDecoration decoration;
  final Widget child;
  final AlignmentGeometry alignment;

  CustomButton({required this.decoration, required this.child, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      alignment: alignment,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Added padding for better button appearance
      child: child,
    );
  }
}
