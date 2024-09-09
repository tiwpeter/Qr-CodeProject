import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poject_qr/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class News1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 92),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFC7253E),
                    ),
                    child: Container(
                      width: 390,
                      height: 72,
                      child: Positioned(
                        left: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0x33000000),
                          ),
                          child: Container(
                            width: 30,
                            height: 24,
                            padding: EdgeInsets.fromLTRB(10.7, 6.2, 12.1, 6.2),
                            child: SizedBox(
                              width: 7.2,
                              height: 11.5,
                              child: SvgPicture.asset(
                                'assets/vectors/Unknown',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 484),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                    ),
                    child: SizedBox(
                      width: 156,
                      height: 45,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 3,
                            bottom: 13,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/play_21.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 18,
                                height: 18,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 31,
                            bottom: 13,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/play_31.png',
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 18,
                                height: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(13, 0, 18, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                    ),
                    child: Container(
                      width: 359,
                      height: 63,
                      child: Positioned(
                        left: 20,
                        bottom: 10,
                        child: Opacity(
                          opacity: 0.5,
                          child: SizedBox(
                            height: 24,
                            child: Text(
                              'More infrom',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 15,
            bottom: 251,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 167,
                height: 45,
              ),
            ),
          ),
          Positioned(
            right: 24,
            bottom: 251,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 167,
                height: 45,
              ),
            ),
          ),
          Positioned(
            right: 24,
            bottom: 167,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 164,
                height: 45,
              ),
            ),
          ),
          Positioned(
            left: 15,
            bottom: 170,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 167,
                height: 45,
              ),
            ),
          ),
          Positioned(
            left: 86,
            bottom: 11,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 70,
                height: 48,
              ),
            ),
          ),
          Positioned(
            right: 132,
            bottom: 11,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 70,
                height: 48,
              ),
            ),
          ),
          Positioned(
            right: 133.3,
            bottom: 261,
            child: SizedBox(
              height: 24,
              child: Text(
                '\$0.00',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            left: 75,
            bottom: 261,
            child: SizedBox(
              height: 24,
              child: Text(
                '\$0.00',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            left: 29,
            bottom: 180,
            child: SizedBox(
              height: 24,
              child: Text(
                '0',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            right: 139.3,
            bottom: 216,
            child: SizedBox(
              height: 24,
              child: Text(
                'Size',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            left: 23,
            bottom: 299,
            child: SizedBox(
              height: 24,
              child: Text(
                'Purchase Price',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            right: 105.3,
            bottom: 304,
            child: SizedBox(
              height: 24,
              child: Text(
                'Sale Price',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            left: 23,
            bottom: 221,
            child: SizedBox(
              height: 24,
              child: Text(
                'Stock',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 16,
            bottom: 360,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 359,
                height: 45,
              ),
            ),
          ),
          Positioned(
            left: 13,
            child: SizedBox(
              height: 24,
              child: Text(
                'item code',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 323,
            child: SizedBox(
              height: 24,
              child: Text(
                'Category',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 347,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 319,
                height: 45,
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 16,
            top: 264,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 359,
                height: 45,
              ),
            ),
          ),
          Positioned(
            left: 13,
            top: 235,
            child: SizedBox(
              height: 24,
              child: Text(
                'warehouse',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            top: 161,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/gallery_11.png',
                  ),
                ),
              ),
              child: Container(
                width: 24,
                height: 24,
              ),
            ),
          ),
          Positioned(
            top: 187,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/camera_1.png',
                  ),
                ),
              ),
              child: Container(
                width: 24,
                height: 24,
              ),
            ),
          ),
          Positioned(
            left: 7,
            top: 91,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 141,
                height: 120,
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 106,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                width: 192,
                height: 45,
              ),
            ),
          ),
          Positioned(
            right: 107.4,
            top: 91,
            child: SizedBox(
              height: 15,
              child: Text(
                'Description',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            right: 118.1,
            top: 149,
            child: SizedBox(
              height: 24,
              child: Text(
                'Stock',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          Positioned(
            right: 19,
            top: 354,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/up_arrow_1.png',
                  ),
                ),
              ),
              child: Container(
                width: 32,
                height: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}