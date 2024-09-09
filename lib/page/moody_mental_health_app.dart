import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poject_qr/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodyMentalHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 63),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 39),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFC7253E),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(29.5, 0, 18, 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 5.5, 16.6, 6.5),
                                    child: Text(
                                      'Shop',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        height: 1.5,
                                        color: Color(0xFFFFF5E4),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 6, 0.4, 6),
                                      child: Text(
                                        'find',
                                        style: GoogleFonts.getFont(
                                          'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          height: 1.5,
                                          color: Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE0E0E0),
                            ),
                            child: Container(
                              width: 390,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(32, 0, 32, 79),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 22),
                        width: 326,
                        height: 262,
                        child: Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFECFDF3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              width: 326,
                              height: 266,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 4, 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFFD6BBFB)),
                                      borderRadius: BorderRadius.circular(999),
                                      color: Color(0xFFF4EBFF),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(15.5, 7, 15.5, 7),
                                      child: Text(
                                        'Add',
                                        style: GoogleFonts.getFont(
                                          'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Color(0xFF6941C6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    padding: EdgeInsets.fromLTRB(0, 7, 0.3, 7),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFFE4E7EC)),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      'Sell',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        height: 1.5,
                                        color: Color(0xFF667085),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15.3, 7, 15.3, 7),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFFE4E7EC)),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      'Search',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        height: 1.5,
                                        color: Color(0xFF667085),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 24, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFAF5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      height: 64,
                                      padding: EdgeInsets.fromLTRB(0, 16, 1, 16),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/add_1.png',
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 24, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFAF5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      height: 64,
                                      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/up_selling_1.png',
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF0F9FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      height: 56,
                                      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/loupe_1.png',
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 78,
                  height: 85,
                  child: SvgPicture.asset(
                    'assets/vectors/Unknown',
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Color(0x40101828),
                  offset: Offset(0, 24),
                  blurRadius: 24,
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/home_05.png',
                        ),
                      ),
                    ),
                    child: Container(
                      width: 32,
                      height: 32,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/stock_11.png',
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/stock_1.png',
                          ),
                        ),
                      ),
                      child: Container(
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 7, 0, 7),
                    width: 24,
                    height: 24,
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: SvgPicture.asset(
                        'assets/vectors/Unknown',
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/icon.png',
                        ),
                      ),
                    ),
                    child: Container(
                      width: 32,
                      height: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}