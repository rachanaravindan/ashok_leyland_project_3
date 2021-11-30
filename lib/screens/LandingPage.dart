import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:ashok_leyland_project_3/screens/signin_page.dart';
import 'package:ashok_leyland_project_3/services/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    User user;
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            user = auth.currentUser;
            if (user.emailVerified) {
              return HomeScreen();
            } else{
              print("user not verified !!");
              return VerifyScreen();
            }
          } else if (snapshot.hasError) {
            return Center(child: Text("Something Went Wrong !!"));
          } else {
            return SignInPage();
          }
        },
      ),
    );
  }
}
