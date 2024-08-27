import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_quest/screens/homeScreen.dart';
import 'package:learn_quest/screens/siginInScreen.dart';
import 'package:learn_quest/utils/colors.dart';
import 'package:learn_quest/utils/fonts.dart';
import 'package:remixicon/remixicon.dart';

class Welcomescreen extends StatefulWidget {
  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen size and pixel ratio
    final size = MediaQuery.of(context).size;
    // Calculate a base unit for sizing
    final baseUnit = size.width / 100;

    return Scaffold(
      backgroundColor: appColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              color: appColors.black.withOpacity(0.04),
              child: Padding(
                padding: EdgeInsets.only(top: baseUnit * 13),
                child: Image.asset(
                  "assets/images/welcome-screen-img.png",
                ),
              ),
            ),
            SizedBox(
              height: baseUnit * 6,
            ),
            // const SizedBox(
            //   height: 24,
            // ),
            Padding(
              padding: EdgeInsets.only(
                left: baseUnit * 4,
                right: baseUnit * 4,
                bottom: baseUnit * 2,
              ),
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        "Unlock Your Potential with",
                        style: GoogleFonts.poppins(
                          fontSize: appFont.subtitle_fs,
                          fontWeight: FontWeight.w500,
                          color: appColors.black,
                        ),
                      ),
                      SizedBox(
                        width: baseUnit * 1.5,
                      ),
                      Text(
                        "LearnQuest",
                        style: GoogleFonts.poppins(
                          fontSize: appFont.subtitle_fs,
                          fontWeight: FontWeight.w700,
                          color: appColors.honoluluBlue.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(
                        width: baseUnit * 1.5,
                      ),
                      Text(
                        "Learning.",
                        style: GoogleFonts.poppins(
                          fontSize: appFont.subtitle_fs,
                          fontWeight: FontWeight.w500,
                          color: appColors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: baseUnit * 24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                        minimumSize: WidgetStateProperty.all<Size>(
                          Size.fromHeight(baseUnit * 14.5),
                        ),
                        backgroundColor: WidgetStateProperty.all<Color>(
                          appColors.honoluluBlue,
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(baseUnit * 2),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.off(
                          () => Signinscreen(),
                          transition: Transition.downToUp,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Icon(
                            Remix.mail_fill,
                            color: appColors.white,
                            size: baseUnit * 4.5,
                          ),
                          const Spacer(),
                          Text(
                            "Continue with Email/Password",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: appFont.body_fs,
                                fontWeight: FontWeight.w500,
                                color: appColors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: baseUnit * 3,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                        minimumSize: WidgetStateProperty.all<Size>(
                          Size.fromHeight(baseUnit * 13.5),
                        ),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(appColors.white),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(baseUnit * 2),
                          ),
                        ),
                        side: WidgetStateProperty.all<BorderSide>(
                          BorderSide(
                            color: appColors.black.withOpacity(0.5),
                            width: 0.5,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.off(
                          () => Homescreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Text(
                        "Continue as Guest",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: appFont.body_fs,
                            fontWeight: FontWeight.w500,
                            color: appColors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: baseUnit * 3,
                  ),
                  Text(
                    "By signing up, you agree to our Terms of Service and Privacy Policy.",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: appFont.sub_body_fs,
                        fontWeight: FontWeight.w500,
                        color: appColors.black.withOpacity(0.5),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
