import 'package:flutter/material.dart';
import 'package:learn_quest/routes/routes.dart';
import 'package:learn_quest/screens/homeScreen.dart';
import 'package:learn_quest/screens/searchScreen.dart';
import 'package:learn_quest/screens/siginInScreen.dart';
import 'package:learn_quest/screens/signUpScreen.dart';
import 'package:learn_quest/screens/splashScreen.dart';
import 'package:learn_quest/screens/welcomeScreen.dart';
import 'package:learn_quest/utils/fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    appFont.initialize(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: appRoutes.splashScreen,
      routes: {
        '/Splashscreen': (context) => Splashscreen(),
        '/Welcomescreen': (context) => Welcomescreen(),
        '/Signinscreen': (context) => Signinscreen(),
        '/Signupscreen': (context) => Signupscreen(),
        '/Homescreen': (context) => Homescreen(),
        '/Searchscreen': (context) => Searchscreen()
      },
    );
  }
}
