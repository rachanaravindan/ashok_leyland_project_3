import 'dart:io';
import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/screens/done_add_screen.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:ashok_leyland_project_3/screens/promotion.dart';
import 'package:ashok_leyland_project_3/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AssesmentListScreen extends StatefulWidget {
  final String empId, operationNo, facultyName, departmentName;
  final Timestamp dateOfCompletion;

  const AssesmentListScreen(
      {Key key,
      this.empId,
      this.operationNo,
      this.facultyName,
      this.dateOfCompletion,
      this.departmentName})
      : super(key: key);
  @override
  _AssesmentListScreenState createState() => _AssesmentListScreenState();
}

class _AssesmentListScreenState extends State<AssesmentListScreen> {
  List<String> assessmentListItems = [
    '1. Able to understand and follow all the safety instructions as per WIS ',
    '2. Able to understand and follow all the work instruction as per WIS',
    '3. Able to understand and follow the critical instruction to meet quality and safety',
    '4. Able to ensure the quality of all the parameters as per WIS',
    '5. Able to use the equipment , tools and gauges appropriately',
    '6. Able to complete the operation at required speed',
    '7. Able to maintain and follow 5S discipline',
    '8. Able to understand and follow the reaction plan when any abnormality is noticed',
    '9. Able to analyze and identify cause for any non-conformance',
    '10. Able to trouble shoot and correct the process when any non-conformance is noticed',
    '11. Able identify and report the failure proactively before it occurs',
    '12. Able to participate in suggestion scheme and any other improvement projects',
    '13. Able to train others'
  ];
  String levelDropDownValue;
  bool showToggleBtn = false, showTextField = false;
  List<String> promotionItems = [
    'Promote to',
    'L2',
    'L3',
    'L4',
  ];
  var passCheckBox = List.filled(13, false);
  var failCheckBox = List.filled(13, false);
  crudMethod _traineeRef = new crudMethod();
  List<int> completedAssesments = [];
  Future<void> getDataFromDb() async {
    await _traineeRef.trainee
        .doc(widget.empId)
        .collection("completed on the job training")
        .doc(widget.operationNo)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> documentData = snapshot.data();
        List receivedList = documentData[
            "department ${widget.departmentName} passed assessments"];

        print(receivedList);
        for (int i = 0; i < receivedList.length; i++) {
          setState(() {
            if (receivedList[i] == 1)
              passCheckBox[i] = true;
            else if (receivedList[i] == 0) failCheckBox[i] = true;
          });
        }
        print("printing the fetched array:");
        print(passCheckBox);
      }
    });
  }

  @override
  Future<void> initState() {
    // TODO: implement initState
    getDataFromDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color getPassColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.green;
    }

    Color getFailColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    int points = 0;
    String findCurrentLevel(var completedAssessments) {
      print("pass array");
      print(passCheckBox);
      for (int i = 0; i < passCheckBox.length; i++) {
        if (passCheckBox[i] == true) {
          points++;
        } else
          break;
      }
      print("points-" + points.toString());
      if (points >= 8 && points < 11)
        return "L2";
      else if (points >= 11 && points < 13)
        return "L3";
      else if (points == 13) return "L4";
    }

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
        body: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(3.w, 3.h, 2.w, 0),
            child: Text(
              "Assessment List",
              style: Constants.boldHeading,
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(5.w),
                itemCount: assessmentListItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(assessmentListItems[index]),
                        ),
                        Expanded(
                          child: Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(
                                  getPassColor),
                              value: passCheckBox[index],
                              onChanged: (bool value) {
                                setState(() {
                                  if (value) failCheckBox[index] = false;
                                  passCheckBox[index] = value;
                                });
                              }),
                        ),
                        Expanded(
                          child: Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(
                                  getFailColor),
                              value: failCheckBox[index],
                              onChanged: (bool value) {
                                setState(() {
                                  if (value) passCheckBox[index] = false;
                                  failCheckBox[index] = value;
                                });
                              }),
                        )
                      ],
                    ),
                  );
                }),
          ),

          //  PROMOTION DROPDOWN
          Padding(
            padding: EdgeInsets.only(left: 3.h, right: 3.h),
            child: DropdownButton<String>(
              isExpanded: true,
              dropdownColor: Colors.white,
              iconSize: 5.h,
              focusColor: Colors.red,
              value: levelDropDownValue,
              //elevation: 5,
              style: TextStyle(color: Colors.black),
              iconEnabledColor: Colors.black,
              items:
                  promotionItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                        // color: Colors.black,
                        ),
                  ),
                );
              }).toList(),
              hint: Text(promotionItems[0]),
              onChanged: (String value) {
                setState(() {
                  levelDropDownValue = value;
                  if (value != "promotion") {
                    showToggleBtn = true;
                  } else
                    showToggleBtn = false;
                  showTextField = false;
                });
              },
            ),
          ),
          //SUBMIT BUTTON
          Padding(
              padding: EdgeInsets.all(4.w),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shadowColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    //color: Colors.amber,

                    padding: EdgeInsets.symmetric(
                        vertical: 1.5.h, horizontal: 7.h),
                    onPrimary: Colors.white // foreground
                    ),
                onPressed: () async {
                  final List<int> dummyList =
                      List.filled(assessmentListItems.length, -1);
                  for (int i = 0; i < passCheckBox.length; i++) {
                    if (passCheckBox[i] == true) dummyList[i] = 1;
                    if (failCheckBox[i] == true) dummyList[i] = 0;
                  }
                  print(dummyList);
                  String currentLevel = findCurrentLevel(passCheckBox);
                  if (currentLevel == levelDropDownValue) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => popupDialog(context),
                    );
                    print(dummyList);
                    print("current level" + currentLevel);
                    await _traineeRef.trainee
                        .doc(widget.empId ?? "Empty")
                        .collection("completed on the job training")
                        .doc(widget.operationNo ?? "Empty")
                        .update({
                      "department ${widget.departmentName} date of completion":
                          widget.dateOfCompletion,
                      "department ${widget.departmentName} operation no":
                          widget.operationNo ?? "Empty",
                      "department ${widget.departmentName} level":
                          currentLevel ?? "Empty",
                      "department ${widget.departmentName} passed assessments":
                          dummyList
                    });
                    await _traineeRef.trainee.doc(widget.empId).update({
                      "department ${widget.departmentName} operation ${widget.operationNo} level ${currentLevel}":
                          widget.dateOfCompletion,
                      "department ${widget.departmentName} operation ${widget.operationNo}":
                          currentLevel
                    });
                  } else {
                    final snackbar =
                        SnackBar(content: const Text('NOT ELIGIBLE'));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
                child: Text('SUBMIT ASSESSMENT'),
              )),
        ]),
      ));
    });
  }
}

//POPUP
Widget popupDialog(BuildContext context) {
  return new AlertDialog(
    content: Container(
      height: 17.0.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("ARE YOU SURE YOU WANT TO PROMOTE??"),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoneMark(
                                  screen: false,
                                )));
                  },
                  child: Text("Yes", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(primary: Color(0xff016FB6)),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No", style: TextStyle(color: Color(0xff016FB6))),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
              ))
            ],
          ),
        ],
      ),
    ),
  );
}
