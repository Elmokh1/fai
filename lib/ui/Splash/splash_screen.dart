import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fai/ui/login/login_screen.dart';

class Splash extends StatelessWidget {
  static const String routename = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration:1000,
      splashTransition: SplashTransition.slideTransition,
      backgroundColor: Colors.white,
      splashIconSize: 800,
      splash: Image.asset("assets/images/fai.png"),
      nextScreen: LoginScreen(),
    );
  }
}
