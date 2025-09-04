import 'package:flutter/material.dart';
import 'package:poject_qr/models/ProductModel.dart';

class SlideInProduct extends StatefulWidget {
  final ProductModel product;

  const SlideInProduct({super.key, required this.product});

  @override
  State<SlideInProduct> createState() => _SlideInProductState();
}

class _SlideInProductState extends State<SlideInProduct>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _offsetAnimation = Tween<Offset>(
            begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.network(
                widget.product.imagePath ??
                    "https://via.placeholder.com/60", // fallback
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("ราคา: ${widget.product.price} บาท"),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  // เพิ่มลงตะกร้า
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
