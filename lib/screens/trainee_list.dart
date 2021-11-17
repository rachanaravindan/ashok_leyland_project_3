import 'package:ashok_leyland_project_3/Constants.dart';
import 'package:ashok_leyland_project_3/my_fav_animations/loading.dart';
import 'package:ashok_leyland_project_3/screens/add_trainee.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:ashok_leyland_project_3/screens/trainee_profile.dart';
import 'package:ashok_leyland_project_3/widgets/custom_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class TraineeList extends StatefulWidget {
  @override
  _traineeListState createState() => _traineeListState();
}

class _traineeListState extends State<TraineeList> {
  final _formKey = GlobalKey<FormState>();
  String _traineeName, _registerNumber, _search;
  DateTime _joiningDate;
  DateTime _fromDate = new DateTime.now();
  DateTime _toDate = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection("trainee")
        .orderBy("empId")
        .snapshots();
    Stream<QuerySnapshot> filter() {
      FirebaseFirestore.instance
          .collection('trainee')
          .where('age', isGreaterThan: 10)
          .get()
          .then((QuerySnapshot doccs) {
        if (doccs.docs.isNotEmpty) {
          print("hello");
          print(doccs.docs[0]["age"]);
        }
      });
    }

    Future<Null> selectFromDate(BuildContext floatcontext) async {
      final DateTime _seldate = await showDatePicker(
          context: floatcontext,
          initialDate: _fromDate,
          firstDate: DateTime(1990),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return SingleChildScrollView(
              child: child,
            );
          });
      if (_seldate != null && _seldate != _fromDate) {
        setState(() {
          _fromDate = _seldate;
        });
      }
    }

    Future<Null> _selectToDate(BuildContext floatcontext) async {
      final DateTime _seldate = await showDatePicker(
          context: floatcontext,
          initialDate: _toDate,
          firstDate: DateTime(1990),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return SingleChildScrollView(
              child: child,
            );
          });
      if (_seldate != null && _seldate != _toDate) {
        setState(() {
          _toDate = _seldate;
        });
      }
    }

    Future<void> _showMyDialog(Map<String, String> mapp) async {
      return showGeneralDialog<void>(
        context: context,
        barrierDismissible: false,
        pageBuilder: (_, __, ___) {
          return SizedBox.expand(
            child: Center(
                child: Row(children: [
              Container(
                
              ),
            ])),
          );
        },
      );
    }
    // Future<void> _showMyDialog() async {
    //   return showDialog<void>(
    //     context: context,
    //     barrierDismissible: false, // user must tap button!
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Filter'),
    //         content: SingleChildScrollView(
    //           child: ListBody(
    //             children: [
    //               GestureDetector(
    //                 onTap: () {
    //                   selectFromdate(context);
    //                 },
    //                 child: Card(
    //                   child: Row(
    //                     children: [
    //                       IconButton(
    //                         onPressed: () {
    //                           _selectTodate(context);
    //                         },
    //                         icon: Icon(Icons.calendar_today),
    //                       ),
    //                       Text('Date: $_formattedate '),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text('Approve'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(3.h),
                      height: 3.0.h,
                      width: 7.0.h,
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Text(
                  'Trainee Details',
                  style: Constants.ListItemHeading,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 6.h,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                        hintText: "Search",
                        focusColor: Colors.black,
                        fillColor: Colors.grey,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(5.w, 3.w, 1.w, 1.w),
                child: Row(
                  children: [
                    ElevatedButton(
                      // style: ElevatedButton.styleFrom(
                      //     // primary: HexColor("#F3F3F3"))

                      onPressed: () {
                        print("im pressed");
                        filter();
                      },
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 1.h),
                              child:
                                  Icon(Icons.filter_list, color: Colors.white)),
                          Text(
                            'Filter',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 25.w,
                ),
                Text(
                  'Name',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 40.w,
                ),
                Text('Id',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black))
              ],
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
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
                        margin: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 2.w),
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
                                  padding:
                                      EdgeInsets.fromLTRB(5.w, 0, 0, 1.2.h),
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
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTrainee()));
            }),
      ));
    });
  }
}
