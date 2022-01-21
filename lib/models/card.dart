import 'package:altraport/constants.dart';
import 'package:altraport/screens/trainee_profile.dart';
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

Widget buildCard(BuildContext context, DocumentSnapshot document, int screen) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  return Bounce(
    duration: Duration(milliseconds: 20),
    onPressed: () {
      String _date;
      _date = data["doj"].toDate().toString();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => traineeProfile(
                  traineeName: data["name"] ??= "null",
                  traineeID: data["empId"] ??= "null",
                  department: data["department"] ??= "null"
                  // joiningDate: "19/03/2001",
                  )));
    },
    child: Card(
      margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
      color: HexColor("#D9E9F2"),
      elevation: 0.5.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
          child: Icon(Icons.person),
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(6.w, 0, 0, 1.2.h),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    data["name"] ??= "null",
                    style: Constants.ListItemHeading,
                  ),
                ),
              )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 0, 1.2.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                data["empId"] ??= "null",
                style: Constants.ListItemSubHeading,
              ),
            ),
          )),
        ],
      ),
    ),
  );
}
