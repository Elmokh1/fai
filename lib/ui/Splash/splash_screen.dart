import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fai/ui/register/register.dart';
import 'package:fai/ui/user_interface/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:fai/ui/login/login_screen.dart';

import '../../import.dart';

class Splash extends StatefulWidget {
  static const String routeName = "SplashScreen";

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 1000,
        splashTransition: SplashTransition.sizeTransition,
        backgroundColor: Colors.white,
        splashIconSize: 800,
        splash: Image.asset("assets/images/agriLogo.png"),
        nextScreen: user != null ? WelcomePage() : RegisterPage());
  }
}
