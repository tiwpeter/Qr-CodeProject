import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyPageQr2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarouselExample(),
    );
  }
}

class CarouselExample extends StatefulWidget {
  @override
  _CarouselExampleState createState() => _CarouselExampleState();
}

class _CarouselExampleState extends State<CarouselExample> {
  final List<String> imageUrls = [
    'assets/icon2/add-product.png', // ใส่ชื่อไฟล์จาก assets ที่ต้องการ
    'assets/icon2/search.png',
    'assets/icon2/direct-marketing.png',
  ];
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carousel Slider")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(15), // Optional: rounded corners
                ),
                child: Column(
                  children: [
                    // Image with a border around it
                    Container(
                      width: 150.0, // กำหนดขนาดของกรอบ
                      height: 150.0, // กำหนดขนาดของกรอบ
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // ทำให้กรอบเป็นวงกลม
                        border: Border.all(
                          color: Colors.red, // สีของกรอบ
                          width: 4, // ความหนาของกรอบ
                        ),
                      ),
                      child: ClipOval(
                        child: Padding(
                          padding: const EdgeInsets.all(
                              30.0), // เพิ่มระยะห่างระหว่างกรอบและภาพ
                          child: Image.asset(
                            // เปลี่ยนจาก Image.network เป็น Image.asset
                            imageUrls[index],
                            width: double.infinity, // ใช้ความกว้างเต็มที่
                            height: double.infinity, // ใช้ความสูงเต็มที่
                          ),
                        ),
                      ),
                    ),

                    // Text below the image
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Image ${index + 1}', // Customize the text here
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: 300.0, // Adjust the height to suit your needs
              enlargeCenterPage: true,
              autoPlay: false,
              viewportFraction:
                  0.4, // Set this to control the visible fraction of the carousel item
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          SmoothPageIndicator(
            controller: _pageController,
            count: imageUrls.length,
            effect: WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.black,
              radius: 4.0,
              dotWidth: 8.0,
              dotHeight: 8.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
