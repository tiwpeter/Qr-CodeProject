import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Nav'),
    ),
    body: Center(
      child: Text(
        'Page Detail',
        style: TextStyle(fontSize: 60),  // Changed from fontStyle to fontSize
      ),
    ),
  );
}
