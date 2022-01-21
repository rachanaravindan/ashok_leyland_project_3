import 'package:altraport/constants.dart';
import 'package:altraport/screens/home.dart';
import 'package:altraport/screens/signin_page.dart';
import 'package:altraport/services/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    User user;
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("user!=null");
      if (!user.emailVerified)
      {
        return VerifyScreen();
      }
      return Scaffold(
        body: Container(
            color: Colors.yellow[200],
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitFoldingCube(
                    color: Colors.blueAccent,
                    size: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Loading", style: Constants.boldHeading),
                  )
                ],
              ),
            ),
          ),
      );
      }
      if (user == null) {
      print("user==null");
      return Scaffold(
        body:Container(
          color: Colors.yellow[200],
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitFoldingCube(
                  color: Colors.blueAccent,
                  size: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading", style: Constants.boldHeading),
                )
              ],
            ),
          ),
        ),
      );
    }
    }
  }
