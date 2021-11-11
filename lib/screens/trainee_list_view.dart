import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/screens/trainee_profile.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';

class TraineeListView extends StatefulWidget {
  @override
  _TraineeListViewState createState() => _TraineeListViewState();
}

class _TraineeListViewState extends State<TraineeListView> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => traineeProfile(
                                traineeName: data["name"],
                                traineeID: data["empId"],
                                joiningDate: data["doj"],
                              )));
                },
                child: Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
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
                                data["name"],
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
                            data["empId"],
                            style: Constants.ListItemSubHeading,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      );
    });
  }
}
