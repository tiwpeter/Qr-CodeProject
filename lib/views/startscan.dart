import 'package:flutter/material.dart';
import 'package:poject_qr/views/ScanPage.dart';
import 'enums/scan_action.dart';

class StartScanPage extends StatelessWidget {
  const StartScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scan Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Set font weight to bold
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 270,
                      height: 200,
                      color: const Color(0xFFECFDF3), // Adjusted color
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(8), // runtime → no const
                        child: Image.asset(
                          'assets/icon/ice.png',
                          fit: BoxFit.cover,
                          width: 270,
                          height: 200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Select your Type to scan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold, // Make the text bold
                      ),
                      textAlign: TextAlign.center, // Center the text
                    ),
                    const SizedBox(
                        height: 20), // Optional spacing below the text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 42),
                          child: Text('Add', style: TextStyle(fontSize: 16)),
                        ),
                        GestureDetector(
                          child: CustomButton(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            hoverColor: Colors.blue.withOpacity(0.2),
                            onPressed: () {
                              print("Button clicked!");
                            },
                            child: const Text("Sell",
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 42),
                          child: Text('search', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ScanPage(
                                    action: ScanAction.addProduct),
                              ),
                            );
                          },
                          child: Image.asset('assets/icon/add.png', height: 32),
                        ),
                        const SizedBox(width: 64),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ScanPage(
                                    action: ScanAction.sellProduct),
                              ),
                            );
                          },
                          child: Image.asset('assets/icon/up-selling.png',
                              height: 32),
                        ),
                        const SizedBox(width: 64),
                        GestureDetector(
                          onTap: () {},
                          child:
                              Image.asset('assets/icon/loupe.png', height: 32),
                        ),
                      ],
                    ),

                    Container(
                      alignment: Alignment.center,
                      width: 72,
                      height: 72,
                      margin: const EdgeInsets.only(top: 56, bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // runtime value (not const)
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final BoxDecoration decoration;
  final Widget child;
  final VoidCallback? onPressed;
  final Color? hoverColor; // สีเมื่อ hover หรือ press

  const CustomButton({
    super.key,
    required this.decoration,
    required this.child,
    this.onPressed,
    this.hoverColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // สี background: ถ้า hover/press ให้เปลี่ยนเป็น hoverColor
    final BoxDecoration currentDecoration = widget.decoration.copyWith(
      color: (_isHovering || _isPressed)
          ? widget.hoverColor ?? Colors.blue.withOpacity(0.2)
          : widget.decoration.color,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: currentDecoration,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: widget.child,
        ),
      ),
    );
  }
}
