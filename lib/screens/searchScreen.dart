import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_quest/utils/colors.dart';
import 'package:learn_quest/utils/fonts.dart';

class Searchscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen size and pixel ratio
    final size = MediaQuery.of(context).size;
    // Calculate a base unit for sizing
    final baseUnit = size.width / 100;

    return Scaffold(
      backgroundColor: appColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: baseUnit * 4, right: baseUnit * 4, top: baseUnit * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: baseUnit * 14,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.circular(baseUnit * 2.5),
                    border: Border.all(color: appColors.black.withOpacity(0.2)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: baseUnit * 2.5, right: baseUnit * 2.5),
                    child: Row(
                      children: [
                        Icon(
                          FlutterRemix.search_2_line,
                          size: baseUnit * 6,
                          color: appColors.black.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: baseUnit * 3,
                        ),
                        Expanded(
                          child: TextField(
                            // autofocus: true,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: appFont.body_fs,
                                fontWeight: FontWeight.w400,
                                color: appColors.black,
                              ),
                            ),
                            decoration: InputDecoration(
                              hintText: "Find course",
                              hintStyle: GoogleFonts.poppins(
                                fontSize: appFont.body_fs,
                                fontWeight: FontWeight.w400,
                                color: appColors.black.withOpacity(0.5),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: baseUnit * 6,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FlutterRemix.history_line,
                          size: baseUnit * 4.5,
                          color: appColors.black,
                        ),
                        SizedBox(
                          width: baseUnit * 1.5,
                        ),
                        Text(
                          "No recent search",
                          style: GoogleFonts.poppins(
                            fontSize: appFont.sub_body_fs,
                            fontWeight: FontWeight.w500,
                            color: appColors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: baseUnit * 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
