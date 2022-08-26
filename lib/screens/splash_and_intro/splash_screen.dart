import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:page_transition/page_transition.dart';

import 'intro_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        "assets/images/app_logo.png",
      ),
      nextScreen: const IntroScreen(),
      // nextScreen: const ToggleScreen(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color.fromRGBO(1, 31, 44, 1),
      splashIconSize: 150.0,
      duration: 4000,
      // pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}