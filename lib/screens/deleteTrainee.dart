import 'package:ashok_leyland_project_3/screens/done_add_screen.dart';
import 'package:ashok_leyland_project_3/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
//import 'package:intl/intl.dart';
import 'package:ashok_leyland_project_3/constants.dart';
//import 'done_add_screen.dart';
import 'home.dart';


class deleteTrainee extends StatefulWidget {
  final String traineeName;
  final String traineeID;

  const deleteTrainee({Key key, this.traineeName, this.traineeID})
      : super(key: key);
  @override
  _deleteTraineeState createState() => _deleteTraineeState();
}

class _deleteTraineeState extends State<deleteTrainee> {
  var _nameController = TextEditingController();
  var _deptController = TextEditingController();
  String _traineeName, _employeeId;
  crudMethod _traineeRef = new crudMethod();
  bool _isDisable = true;

  showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
       Navigator.push(
          context, MaterialPageRoute(builder: (context) => deleteTrainee()));
    },
  );
  Widget continueButton = TextButton(
    child: Text("Delete"),
    onPressed: () async {
      await FirebaseFirestore.instance.collection('trainee').doc(_employeeId).delete();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DoneMark(screen: false
          )));
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Delete Trainee"),
    content: Text(
        "Are you sure you would like to delete this Trainee from the database?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

  
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
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
                          margin: EdgeInsets.only(top: 3.h),
                          height: 5.0.h,
                          width: 6.0.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
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
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Delete Trainee',
                      style: Constants.boldHeading,
                    ),
                  ],
                ),

                //EMPLOYEE ID
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (input) {
                      _employeeId = input;
                      setState(() async {
                        DocumentSnapshot snapshot =
                            await _traineeRef.trainee.doc(_employeeId).get();
                        Map<String, dynamic> documentData = snapshot.data();
                        print(documentData["name"] ?? "Null");
                        print(documentData["department"] ?? "Null");
                        _nameController.text = documentData["name"] ?? "Null";
                        _deptController.text =
                            documentData["department"] ?? "Not Allocated";
                      });
                    },
                    decoration: InputDecoration(labelText: 'Employee Id'),
                  ),
                ),

                // NAME
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nameController,
                    onChanged: (input) {
                      _traineeName = input;
                      setState(() {
                        if (input.isEmpty)
                          _isDisable = true;
                        else
                          _isDisable = false;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Name'),
                    enabled: false,
                    enableInteractiveSelection: true,
                  ),
                ),

                // DEPARTMENT
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _deptController,
                    onChanged: (input) {
                      _traineeName = input;
                      setState(() {
                        if (input.isEmpty)
                          _isDisable = true;
                        else
                          _isDisable = false;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Department'),
                    enabled: false,
                    enableInteractiveSelection: true,
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shadowColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          //color: Colors.amber,

                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 11.6.h),
                          onPrimary: Colors.white // foreground
                          ),
                      onPressed: () async {
                        
                        showAlertDialog(context);
                      },
                      child: Text('Delete Trainee'),
                    ))
              ]),
            ),
          ),
        ),
      );
    });
  }
}


