import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/screens/trainee_profile.dart';
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

Widget buildCard(BuildContext context, DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  print("name" + data["name"]);

//   return new Sizer(builder: (context, orientation, deviceType) {
//     return InkWell
//       child: Card(
//         margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
//         color: HexColor("#D9E9F2"),
//         elevation: 0.5.h,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Center(
//               child: Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CircleAvatar(
//                   child: Icon(Icons.person),
//                 ),
//               )),
//             ),
//             Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(5.w, 0, 0, 1.2.h),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Text(
//                       data["name"] ??= "null",
//                       style: Constants.ListItemHeading,
//                     ),
//                   ),
//                 )),
//             Expanded(
//                 child: Padding(
//               padding: EdgeInsets.fromLTRB(12.w, 0, 0, 1.2.h),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Text(
//                   data["empId"] ??= "null",
//                   style: Constants.ListItemSubHeading,
//                 ),
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   });
// }

  return Bounce(
    onPressed: () {
      String _date;
      _date= data["doj"].toDate().toString();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => traineeProfile(
                    traineeName: data["name"] ??= "null",
                    traineeID: data["empId"] ??= "null",
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
          Center(
            child: Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            )),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5.w, 0, 0, 1.2.h),
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
