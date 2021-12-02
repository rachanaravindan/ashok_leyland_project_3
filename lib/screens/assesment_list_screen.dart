import 'package:ashok_leyland_project_3/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AssesmentListScreen extends StatefulWidget {
  final String empId, operationNo, facultyName;
  final Timestamp dateOfCompletion;

  const AssesmentListScreen(
      {Key key,
      this.empId,
      this.operationNo,
      this.facultyName,
      this.dateOfCompletion})
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
  var passCheckBox = List.filled(13, false);
  var failCheckBox = List.filled(13, false);
  crudMethod _traineeRef = new crudMethod();
  List<int> completedAssesments = [];
  Future<void> getDataFromDb() async {
    DocumentSnapshot snapshot = await _traineeRef.trainee
        .doc(widget.empId)
        .collection("completed training")
        .doc(widget.operationNo)
        .get();
    Map<String, dynamic> documentData = snapshot.data();
    List receivedList = documentData["completed assesments"];
    print(receivedList);
    for (var i in receivedList) {
      passCheckBox[i] = true;
    }
    print(passCheckBox);
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

    String findCurrentLevel(int points) {
      print("points:" + points.toString());
      if (points < 8)
        return "L1";
      else if (points >= 8 && points < 11)
        return "L2";
      else if (points >= 11 && points < 13)
        return "L3";
      else if (points == 13) return "L4";
    }

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
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
              ElevatedButton(
                  onPressed: () async {
                    for (int i = 0; i < passCheckBox.length; i++) {
                      if (passCheckBox[i] == true) completedAssesments.add(i);
                    }

                    await _traineeRef.trainee
                        .doc(widget.empId ?? "Empty")
                        .collection("completed on the job training")
                        .doc(widget.operationNo ?? "Empty")
                        .set({
                      "date of completion": widget.dateOfCompletion,
                      "operation no": widget.operationNo ?? "Empty",
                      "faculty name": widget.facultyName ?? "Empty",
                      "Level": findCurrentLevel(completedAssesments.length) ?? "Empty"
                    });

                    await _traineeRef.trainee
                        .doc(widget.empId)
                        .collection("completed on the job training")
                        .doc(widget.operationNo)
                        .update({
                      "completed assessments":
                          completedAssesments
                    });
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      );
    });
  }
}
