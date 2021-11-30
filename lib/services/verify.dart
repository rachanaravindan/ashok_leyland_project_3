import 'dart:async';

import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:ashok_leyland_project_3/screens/signin_page.dart';
import 'package:ashok_leyland_project_3/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'dart:io';
import 'package:sizer/sizer.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    user = auth.currentUser;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      print("Email Verified !!");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  Future<void> openEmailApp(BuildContext context) async {
    var result = await OpenMailApp.openMailApp(
                  nativePickerTitle: 'Select email app to open',
                );

                // If no mail apps found, show error
                if (!result.didOpen && !result.canOpen) {
                  showNoMailAppsDialog(context);

                  // iOS: if multiple mail apps found, show dialog to select.
                  // There is no native intent/default app system in iOS so
                  // you have to do it yourself.
                } else if (!result.didOpen && result.canOpen) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return MailAppPickerDialog(
                        mailApps: result.options,
                      );
                    },
                  );
                }
  }
  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthService authObj;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Text(
                        "An email has been sent to ${user.email} Please verify",
                        style: Constants.ListItemHeading)),
                ElevatedButton(
                    onPressed: () {
                      // authObj.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()));
                    },
                    child: Text("Go Back")),
                ElevatedButton.icon(
                    onPressed: () {
                      openEmailApp(context);
                    },
                    icon: Icon(Icons.email_outlined),
                    label: Text("Open Gmail"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
