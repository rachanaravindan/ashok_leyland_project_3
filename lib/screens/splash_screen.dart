import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ashok_leyland_project_3/screens/LandingPage.dart';
import 'package:ashok_leyland_project_3/screens/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class Splash extends StatefulWidget {
  // Splash({Key? key }) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    //_navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: AnimatedSplashScreen(
            splashIconSize: 20.h,
            splash: Image(
              image: AssetImage("assets/logo.png"),
              
              ),
            duration: 1200,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white,
            nextScreen: Authenticate(), 
            
        ),
      );
    });
  }
}
