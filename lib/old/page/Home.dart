import 'package:flutter/material.dart';


void mainTop() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home ({super.key});

  @override
  Widget build(context) {
    return const Text('This Page');
  }
}
