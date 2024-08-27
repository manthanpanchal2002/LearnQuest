import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:learn_quest/screens/homeScreen.dart';
import 'package:learn_quest/screens/welcomeScreen.dart';
import 'package:learn_quest/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  String? token;

  // Check for user-token
  checkIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userAccessToken');
  }

  @override
  void initState() {
    super.initState();
    checkIsLoggedIn();
    animate();
  }

  Future<void> animate() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (token != null) {
      // Navigate user to home screen
      Get.off(
        () => Homescreen(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    } else {
      // Navigate user to welcome screen
      Get.off(
        () => Welcomescreen(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size and pixel ratio
    final size = MediaQuery.of(context).size;
    // Calculate a base unit for sizing
    final baseUnit = size.width / 100;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: appColors.white,
        body: SafeArea(
          child: Center(
            child: Image.asset(
              'assets/images/learnquest logo.png',
              height: baseUnit * 10,
            ),
          ),
        ),
      ),
    );
  }
}
