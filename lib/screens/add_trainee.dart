import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:ashok_leyland_project_3/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class AddTrainee extends StatefulWidget {
  @override
  _AddTraineeState createState() => _AddTraineeState();
}

class _AddTraineeState extends State<AddTrainee> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _traineeName, _employeeId, _traineeQualifications, _traineeAge;
  DateTime _joiningDate;
  DateTime currentDate = new DateTime.now();
  bool _isDisable = false;
  bool showToggleBtn = false, showTextField = false;
  List<String> GenderItems = ['Gender', 'Male', 'Female', 'Others'];
  String GenderDropDownValue;
  void initState() {
    var GenderDropDownValue = GenderItems[0];
    super.initState();
  }

  Future<Null> _selectdate(BuildContext floatcontext) async {
    final DateTime _seldate = await showDatePicker(
        context: floatcontext,
        initialDate: currentDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_seldate != null && _seldate != currentDate) {
      setState(() {
        print(_seldate);
        currentDate = _seldate;
        _selectdate(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Future<void> addUser() {
    //   // Call the user's CollectionReference to add a new user
    //   return users
    //       .add({
    //         'full_name': "sharan deepal", // John Doe
    //         'company': "the fcking company", // Stokes and Sons
    //         'age': "69" // 42
    //       })
    //       .then((value) => print("User Added"))
    //       .catchError((error) => print("Failed to add user: $error"));
    // }

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
          body: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Add Trainee",
                    style: Constants.boldHeading,
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectdate(context);
                        });
                      },
                      child: Card(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectdate(context);
                                });
                              },
                              icon: Icon(Icons.calendar_today),
                            ),
                            Text('Date Of Joining: $_formattedate'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (input) {
                        _traineeQualifications = input;
                        setState(() {
                          if (input.isEmpty)
                            _isDisable = true;
                          else
                            _isDisable = false;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Qualifications'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconSize: 5.h,
                      focusColor: Colors.red,
                      value: GenderDropDownValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      iconEnabledColor: Colors.black,
                      items: GenderItems.map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Text(GenderItems[0]),
                      onChanged: (String value) {
                        setState(() {
                          GenderDropDownValue = value;
                          if (value != "Gender") {
                            showToggleBtn = true;
                          } else
                            showToggleBtn = false;
                          showTextField = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (input) {
                        _traineeAge = input;
                        setState(() {
                          if (input.isEmpty)
                            _isDisable = true;
                          else if (isNumeric(input)) _isDisable = false;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Age'),
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
                        onPressed: _isDisable
                            ? null
                            : () {
                                print("Submitted");
                                // addUser();
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

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
