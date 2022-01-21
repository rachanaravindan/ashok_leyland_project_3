import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:altraport/screens/LandingPage.dart';
import 'package:altraport/screens/home.dart';
import 'package:altraport/screens/signin_page.dart';
import 'package:altraport/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          accentColor: Color(0xFFFF1E00)),
      title: 'Ashok_leyland',
      home: Splash(),
    );
  }
}
