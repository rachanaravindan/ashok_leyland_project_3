import 'package:ashok_leyland_project_3/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:ashok_leyland_project_3/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentAllocation extends StatefulWidget {
  @override
  _DepartmentAllocationState createState() => _DepartmentAllocationState();
}

class _DepartmentAllocationState extends State<DepartmentAllocation> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _traineeName, _employeeId, _traineeQualifications, _traineeAge;
  DateTime _joiningDate;
  DateTime currentDate = new DateTime.now();
  bool _isDisable = false;
  bool showToggleBtn = false, showTextField = false;
  List<String> departmentItems = [
    'Department',
    'Chassis & Frame Assembly',
    'GB Assembly',
    'HT'
  ];
  String departmentDropDownValue;
  crudMethod crudOperations = new crudMethod();
  void initState() {
    var departmentDropDownValue = departmentItems[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.parse(s, (e) => null) != null;
    }

    String _formattedate = new DateFormat.yMMMd().format(currentDate);

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.yellow[00],
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(2.w, 5.h, 2.w, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Department Allocation",
                    style: Constants.boldHeading,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(2.w, 5.h, 2.w, 0),
                    child: TextField(
                      onChanged: (input) {
                        _employeeId = input;
                        setState(() {
                          if (input.isEmpty)
                            _isDisable = true;
                          else if (isNumeric(input)) _isDisable = false;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Employee Id'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconSize: 5.h,
                      focusColor: Colors.red,
                      value: departmentDropDownValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      iconEnabledColor: Colors.black,
                      items: departmentItems
                          .map<DropdownMenuItem<String>>((String value) {
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
                      hint: Text(departmentItems[0]),
                      onChanged: (String value) {
                        setState(() {
                          departmentDropDownValue = value;
                          if (value != "department") {
                            showToggleBtn = true;
                          } else
                            showToggleBtn = false;
                          showTextField = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,

                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 11.6.h),
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          print("Submitted");
                          // crudOperations.storeData({});
                        },
                        child: Text('Submit')),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
