import 'package:flutter/material.dart';

class AnimatedProductPopup extends StatefulWidget {
  final String productName;

  AnimatedProductPopup({required this.productName});

  @override
  _AnimatedProductPopupState createState() => _AnimatedProductPopupState();
}

class _AnimatedProductPopupState extends State<AnimatedProductPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward().then((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.of(context).pop(); // ปิดป๊อปอัพหลังจากจางหายไป
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: AlertDialog(
          title: Text('Product Scanned'),
          content: Text(widget.productName),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิดป๊อปอัพด้วยปุ่ม
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
