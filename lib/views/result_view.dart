import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  final String result;

  const ResultView({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ผลการสแกน')),
      body: Center(
        child: Text(
          result,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
