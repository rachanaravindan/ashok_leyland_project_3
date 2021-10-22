//This screen is for signing the user
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  height: 7.0.h,
                  width: 10.0.h,
                  child: Image.asset(
                    "assets/logo.png",
                  )),
            ],
          )
        ],
      );
    });
  }
}
