import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/screens/done_add_screen.dart';
import 'package:ashok_leyland_project_3/screens/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sizer/sizer.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email;
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String domain_name = "@gmail.com";


  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  width: 2.w,
                  height: 2.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 1.h),
                    height: 5.0.h,
                    width: 6.0.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(5),
                        primary: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset Password',
                      style: Constants.boldHeading,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (value) {                    
                      if (!value.isEmpty && _email.length > domain_name.length && _email.substring(_email.length - domain_name.length) == domain_name) {
                        return null;
                      } else {
                        return "Enter valid email id";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      padding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 7.h),
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      // ignore: unused_local_variable
                      final isValid = _formKey.currentState.validate();
                      if (isValid) {
                        auth.sendPasswordResetEmail(email: _email);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(context),
                        );
                      }
                    },
                    child: Text('Send Request'),
                  ),
                )
              ],
            ),
          ),
        ))),
      );
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Email has been sent!!!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Kindly check your email."),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignInPage()));
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
