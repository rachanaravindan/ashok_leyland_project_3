import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/my_fav_animations/loading.dart';
import 'package:ashok_leyland_project_3/screens/sdc_training.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'sdc_query.dart';

class traineeProfile extends StatefulWidget {
  final String traineeName;
  final String traineeID;
  final String joiningDate;
  final String department;
  const traineeProfile(
      {Key key,
      this.traineeName,
      this.traineeID,
      this.joiningDate,
      this.department})
      : super(key: key);

  @override
  _traineeProfileState createState() => _traineeProfileState();
}

class _traineeProfileState extends State<traineeProfile> {
  Future<void> _showMyDialog(Map<String, String> mapp) async {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) {
        return SizedBox.expand(
            child: Center(
          child: Container(
            color: Colors.blue[100],
            child: DataTable(
              dividerThickness: 1.0,
              headingRowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.08);
                return null; // Use the default value.
              }),
              columns: [
                DataColumn(
                    label: Text("",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text("",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("Name",
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(mapp["name"])),
                ]),
                DataRow(cells: [
                  DataCell(Text("Employee ID",
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(mapp["empId"])),
                ]),
                DataRow(cells: [
                  DataCell(Text("Day",
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(mapp["day"].toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text("Training",
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(mapp["training"])),
                ]),
                // DataRow(cells: [
                //   DataCell(Text("Mentor")),
                //   DataCell(Text(mapp["mentor"])),
                // ]),
                DataRow(cells: [
                  DataCell(Text("Date of Completion",
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(mapp["doj"])),
                ]),
                DataRow(cells: [
                  DataCell(
                      Text("", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text("")),
                ]),
              ],
            ),
          ),
        ));
      },
    );
  }

  Future<void> _showMyOTJTDialog(Map<String, String> mapp) async {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) {
        return SizedBox.expand(
            child: Center(
          child: Container(
            color: Colors.blue[100],
            child: DataTable(
              dividerThickness: 1.0,
              headingRowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.08);
                return null; // Use the default value.
              }),
              columns: [
                DataColumn(
                    label: Text("",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text("",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("Name",
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(mapp["name"])),
                ]),
                DataRow(cells: [
                  DataCell(Text("Employee ID",
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(mapp["empId"])),
                ]),
                DataRow(cells: [
                  DataCell(Text("Mentor")),
                  DataCell(Text(mapp["mentor"])),
                ]),
                DataRow(cells: [
                  DataCell(Text("Date of Completion",
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(mapp["doj"])),
                ]),
                DataRow(cells: [
                  DataCell(
                      Text("", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text("")),
                ]),
              ],
            ),
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.department);
    final Stream<QuerySnapshot> _marksStream = FirebaseFirestore.instance
        .collection("trainee")
        .doc(widget.traineeID)
        .collection("completed training")
        .snapshots();
    final Stream<QuerySnapshot> _levelStream = FirebaseFirestore.instance
        .collection("trainee")
        .doc(widget.traineeID)
        .collection("completed on the job training")
        .snapshots();
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: HexColor("#D9E9F2"),
        body: Column(
          children: [
            // BACK ARROW==================================================
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
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
            // CIRCLE AVATAR==============================================
            Container(
              child: Expanded(
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.only(left: 2.h, top: 2.h),
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 7.h,
                          color: Colors.white,
                        ),
                        radius: 5.h,
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 3.h, top: 1.h),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.traineeName,
                      style: TextStyle(
                          fontSize: 3.h,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 3.h, top: 1.h),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Employee Id :  ' + widget.traineeID,
                      style: Constants.ListItemSubHeading,
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 3.h, top: 1.h),
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     'Joining Date :  ' + widget.joiningDate,
                  //     style: Constants.ListItemSubHeading,
                  //   ),
                  // ),
                  SizedBox(
                    height: 7.h,
                  ),

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text('Training'),
                          )),
                      Expanded(child: Text('Pre Test')),
                      Expanded(child: Text('Post Test')),
                    ],
                  ),

                  // SDC Training listview starting=====================================================
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _marksStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Loading();
                        }
                        return ListView(
                          //  physics: NeverScrollableScrollPhysics(),
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return Card(
                              color: data["pre_test_marks"] < 50
                                  ? Colors.red.shade400
                                  : Colors.green,
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(0.8.h),
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 0.5.h, horizontal: 3.w),
                              //  color: HexColor("#D9E9F2"),
                              elevation: 0.7.h,
                              child: InkWell(
                                onTap: () {
                                  _showMyDialog({
                                    "name": widget.traineeName,
                                    "empId": widget.traineeID,
                                    "training": data["training"],
                                    "day": data["day"],
                                    "doj":
                                        data["date of completion"].toString(),
                                    "mentor": data["mentor"]
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          data["training"].toString(),
                                          style: Constants.ListItemSubHeading,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                      data["pre_test_marks"].toString(),
                                      style: Constants.ListItemSubHeading,
                                    )),
                                    Expanded(
                                        child: Text(
                                      data["post_test_marks"].toString(),
                                      style: Constants.ListItemSubHeading,
                                    ))
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _levelStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Loading();
                        }
                        return ListView(
                          //  physics: NeverScrollableScrollPhysics(),
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(0.8.h),
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 0.5.h, horizontal: 3.w),
                              //  color: HexColor("#D9E9F2"),
                              elevation: 0.7.h,
                              child: InkWell(
                                onTap: () {
                                  _showMyDialog({
                                    "name": widget.traineeName,
                                    "empId": widget.traineeID,
                                    "doj":
                                        data["department ${widget.department} date of completion"]
                                                .toString() ??
                                            "Empty",
                                    "mentor": data[
                                            "department ${widget.department} faculty name"] ??
                                        "Empty"
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          data["department ${widget.department} operation no"] ??
                                              "Empty",
                                          style: Constants.ListItemSubHeading,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                      data["department ${widget.department} level"] ??
                                          "Empty",
                                      style: Constants.ListItemSubHeading,
                                    )),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ));
    });
  }
}
