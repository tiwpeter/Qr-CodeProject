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
                  borderRadius:
                      BorderRadius.circular(15), // Optional: rounded corners
                ),
                child: Column(
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                        width: double.infinity, // Take up full width
                        height: 230.0, // Adjust height
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
                  0.6, // Set this to control the visible fraction of the carousel item
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
