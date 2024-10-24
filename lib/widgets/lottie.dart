import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedLottieSwitcher extends StatefulWidget {
  @override
  _AnimatedLottieSwitcherState createState() => _AnimatedLottieSwitcherState();
}

class _AnimatedLottieSwitcherState extends State<AnimatedLottieSwitcher> {
  bool _showFirstAnimation = true;

  void _toggleAnimation() {
    setState(() {
      _showFirstAnimation = !_showFirstAnimation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lottie with Mixed Effects')),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (Widget child, Animation<double> animation) {
            // สร้าง Tween สำหรับการเลื่อนและการย่อ
            final slideAnimation = Tween<Offset>(
              begin: const Offset(0.0, 0.2), // เลื่อนไปข้างล่าง
              end: Offset.zero,
            ).animate(animation);

            // สร้าง Scale Transition
            final scaleAnimation = Tween<double>(
              begin: 0.5, // ย่อลง
              end: 1.0,
            ).animate(animation);

            // คอมบิเนชันเอฟเฟกต์
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: slideAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: child,
                ),
              ),
            );
          },
          child: _showFirstAnimation
              ? Lottie.asset('assets/animation1.json', key: ValueKey(1))
              : Lottie.asset('assets/animation2.json', key: ValueKey(2)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleAnimation,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AnimatedLottieSwitcher(),
  ));
}
