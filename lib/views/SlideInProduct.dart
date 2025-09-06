import 'dart:io';
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

  late ImageProvider imageProvider;
  bool _imageInitialized = false;

  @override
  void initState() {
    super.initState();

    // สร้าง Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _offsetAnimation = Tween<Offset>(
            begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_imageInitialized) {
      // เตรียม ImageProvider
      if (widget.product.imagePath != null &&
          widget.product.imagePath!.isNotEmpty) {
        imageProvider = ResizeImage(
          FileImage(File(widget.product.imagePath!)),
          width: 60,
          height: 60,
        );
      } else {
        imageProvider = const NetworkImage("https://via.placeholder.com/60");
      }

      // preload image
      precacheImage(imageProvider, context);
      _imageInitialized = true;
    }
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
              // แสดงภาพ local หรือ fallback network
              Image(
                image: imageProvider,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    "https://via.placeholder.com/60",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  );
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
