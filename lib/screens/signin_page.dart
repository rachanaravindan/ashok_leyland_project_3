import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/my_fav_animations/loading.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
//import 'package:ashok_leyland_project_3/screens/forgot_password.dart';
import 'package:ashok_leyland_project_3/services/auth.dart';
import 'package:ashok_leyland_project_3/services/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'forget_password.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _pwdcontroller = TextEditingController();
  bool circular = false,
      obscure = true,
      visibility = false,
      _validate = true,
      _isLoading = false;

  final formKey = GlobalKey<FormState>();
  final formPassKey = GlobalKey<FormState>();
  String buttonText = "Sign In";

  String getMessageFromErrorCode(String errorCode) {
    setState(() {
      _isLoading = false;
    });
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
        break;
      default:
        return "Couldn't Log In, Check your Internet Connection";
        break;
    }
  }

  Future<String> register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((_) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => VerifyScreen())));
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(String error) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(error)],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    AuthService _authObj = AuthService();
    print("visibility - " + visibility.toString());
    return Sizer(builder: (context, orientation, deviceType) {
      return _isLoading
          ? Loading()
          : SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Form(
                          key: formKey,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,

                            //LOGO, IMAGE
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(left: 27.0.h, right: 0.4.h),
                                child: Image.asset(
                                  "assets/logo.png",
                                  width: 25.0.w,
                                  height: 10.0.h,
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                                buttonText,
                                style: Constants.boldHeading,
                                textAlign: TextAlign.left,
                              ),
                              Container(
                                height: 32.0.h,
                                child: SvgPicture.asset("assets/workplace.svg"),
                              ),
                              //EMAIL
                              Container(
                                width: MediaQuery.of(context).size.width - 70,
                                child: TextFormField(
                                  controller: _emailcontroller,
                                  onChanged: (val) {
                                    formKey.currentState.validate();
                                  },
                                  obscureText: false,
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter valid input' : null,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email_outlined),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.02 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height,
                                          horizontal: 0.02 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height),
                                      labelText: "Email",
                                      labelStyle: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.cyan,
                                          width: 2.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.indigoAccent,
                                          )),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.red,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.black,
                                          ))),
                                ),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Form(
                        key: formPassKey,
                        child: Column(
                          children: [
                            //PASSWORD
                            Container(
                              width: MediaQuery.of(context).size.width - 70,
                              child: TextFormField(
                                controller: _pwdcontroller,
                                onChanged: (val) {
                                  formPassKey.currentState.validate();
                                },
                                obscureText: obscure,
                                validator: (val) =>
                                    val.isEmpty ? 'Enter valid input' : null,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock_outlined),
                                    suffixIcon: visibility
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                visibility = false;
                                                obscure = true;
                                              });
                                            },
                                            icon: Icon(Icons.visibility))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                visibility = true;
                                                obscure = false;
                                              });
                                            },
                                            icon: Icon(Icons.visibility_off)),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.02 *
                                            MediaQuery.of(context).size.height,
                                        horizontal: 0.02 *
                                            MediaQuery.of(context).size.height),
                                    labelText: "Password",
                                    labelStyle: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.cyan,
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.indigoAccent,
                                        )),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.black,
                                        ))),
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 1000),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    child: child, scale: animation);
                              },
                              child: colorbutton(buttonText, () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                if (formKey.currentState.validate() &&
                                    formPassKey.currentState.validate()) {
                                  if (buttonText == "Create an Account") {
                                    String e = await register(
                                        _emailcontroller.text,
                                        _pwdcontroller.text);
                                    if (e == 'weak-password') {
                                      _showMyDialog("Weak Password");
                                    } else if (e == 'email-already-in-use') {
                                      _showMyDialog(
                                          'The account already exists for that email.');
                                    } else {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  } else {
                                    String e = await _authObj.signIn(
                                        _emailcontroller.text,
                                        _pwdcontroller.text);
                                    print(e);
                                    if (e != null) {
                                      _showMyDialog(getMessageFromErrorCode(e));
                                    } else {
                                      setState(() {
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomeScreen())
                                        );
                                      });
                                    }
                                  }
                                }
                              }),
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            Column(
                              children: [
                                Text("Or"),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (buttonText == "Create an Account")
                                          buttonText = "Sign In";
                                        else
                                          buttonText = "Create an Account";
                                      });
                                    },
                                    child: buttonText == "Create an Account"
                                        ? Text(
                                            "Sign In",
                                            style: Constants.ListItemHeading,
                                          )
                                        : Text(
                                            "Create an Account",
                                            style: Constants.ListItemHeading,
                                          ))
                              ],
                            ),
                            TextButton(
                              child: Text(
                                'Forgot Password?',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassword()));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
    });
  }
}

//SIGN IN BUTTON
Widget colorbutton(String hintText, Function onTapFunction) {
  return Sizer(builder: (context, orientation, deviceType) {
    return Container(
      width: MediaQuery.of(context).size.width - 90,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.indigo,
                Colors.indigoAccent,
              ])),
      child: Center(
        child: InkWell(
          child: Text(
            hintText,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onTap: onTapFunction,
        ),
      ),
    );
  });
}

// Widget textview(String labeltext, TextEditingController controller, bool isPass,
//     Icon icon) {
//   bool obscuretext = true;
//   return Sizer(builder: (context, orientation, deviceType) {
//     return Container(
//       width: MediaQuery.of(context).size.width - 70,
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscuretext,
//         validator: (val) => val.isEmpty ? 'Enter valid input' : null,
//         decoration: InputDecoration(
//             prefixIcon: icon,
//             suffixIcon: visibility
//                 ? IconButton(
//                     onPressed: () {
//                       print(": )");

//                     },
//                     icon: Icon(Icons.visibility_off))
//                 : IconButton(
//                     onPressed: () {
//                       print(": )");

//                     },
//                     icon: Icon(Icons.visibility)),
//             contentPadding: EdgeInsets.symmetric(
//                 vertical: 0.02 * MediaQuery.of(context).size.height,
//                 horizontal: 0.02 * MediaQuery.of(context).size.height),
//             labelText: labeltext,
//             labelStyle: TextStyle(
//               fontSize: 17,
//               color: Colors.black,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               borderSide: BorderSide(
//                 color: Colors.cyan,
//                 width: 2.0,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(
//                   width: 1,
//                   color: Colors.indigoAccent,
//                 )),
//             errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(
//                   width: 1,
//                   color: Colors.red,
//                 )),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(
//                   width: 1,
//                   color: Colors.black,
//                 ))),
//       ),
//     );
//   });
// }

Widget textItem(
    String labeltext, TextEditingController controller, bool obscureText) {
  return Sizer(builder: (context, orientation, deviceType) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  });
}
