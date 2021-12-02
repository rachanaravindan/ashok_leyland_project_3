import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:ashok_leyland_project_3/screens/signin_page.dart';
import 'package:ashok_leyland_project_3/services/verify.dart';
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
        return VerifyScreen();
    } else {
      return Container(
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
      );
    }
  }
}
