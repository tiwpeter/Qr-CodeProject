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
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBgCPQmyPHrOWxnUvbmQIRwOipjW8woZUreA&s',
    'https://via.placeholder.com/400x200.png?text=Green',
    'https://via.placeholder.com/400x200.png?text=Blue',
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
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image with circular border, padding, background color
                    Expanded(
                      flex: 3,
                      child: Center(
                        // Center the image within the container
                        child: Container(
                          // Frame ***
                          padding: EdgeInsets.all(
                              16.0), // Padding between the image and the border
                          decoration: BoxDecoration(
                            color: Colors
                                .blue, // Background color of the circular frame
                            shape: BoxShape
                                .circle, // Ensures the container is circular
                            border: Border.all(
                              color: Colors
                                  .red, // Border color (change to any color you like)
                              width: 4.0, // Border width (adjust as needed)
                            ),
                          ),
                          child: Image.network(
                            imageUrls[index],
                            fit: BoxFit.cover,
                            width: 150.0, // Image width (not circular now)
                            height: 150.0, // Image height (not circular now)
                          ),
                        ),
                      ),
                    ),
                    // Text at the bottom
                    Expanded(
                      flex: 1,
                      child: Container(
                        color:
                            Colors.black54, // Semi-transparent overlay for text
                        child: Center(
                          child: Text(
                            'Image ${index + 1}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
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
