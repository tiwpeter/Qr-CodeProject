import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(4, 0, 4, 518),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFC7253E),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Shop',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color(0xFFFFF5E4),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Color(0xFF000000),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF), // White background color
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                  ),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'All',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color(0xFFFFF5E4),
                                ),
                              ),
                            ),
                            Container(
                              width: 32,
                              height: 32,
                              child: Image.asset(
                                'assets/images/menu_11.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Color(0xFFE0E0E0),
                        height: 1,
                      ),
                    ],
                  ),
                ),
                //Colum Stock
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFEAECF5)),
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFF8F9FC),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 23, 35.5, 23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bankok',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Image.asset(
                        'assets/images/delete_1.png',
                        width: 16,
                        height: 16,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        '0',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Image.asset(
                        'assets/images/add_11.png',
                        width: 16,
                        height: 16,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ),
          
           
        ],
      ),
    );
  }
}
