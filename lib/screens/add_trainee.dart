import 'package:altraport/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:altraport/constants.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'done_add_screen.dart';
import 'home.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class AddTrainee extends StatefulWidget {
  @override
  _AddTraineeState createState() => _AddTraineeState();
}

class _AddTraineeState extends State<AddTrainee> {
  final _formKey = GlobalKey<FormState>();
  crudMethod _traineeRef = new crudMethod();
  String _traineeName, _employeeId, _traineeQualifications, _traineeAge;
  DateTime _joiningDate;
  DateTime currentDate = new DateTime.now();
  DateTime currentBirthDate = new DateTime.now();
  bool _isDisable = false;
  bool showToggleBtn = false, showTextField = false;
  List<String> GenderItems = ['Gender', 'Male', 'Female', 'Others'];
  String GenderDropDownValue;
  crudMethod crudOperations = crudMethod();
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
      });
    }
  }

  Future<Null> _selectBirthdate(BuildContext floatcontext) async {
    final DateTime _selbirthdate = await showDatePicker(
        context: floatcontext,
        initialDate: currentBirthDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_selbirthdate != null && _selbirthdate != currentBirthDate) {
      setState(() {
        print(_selbirthdate);
        currentBirthDate = _selbirthdate;
      });
    }
  }

  Future<void> _showMyDialog(String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(error)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
    String _formatteBirthdate = new DateFormat.yMMMd().format(currentBirthDate);

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.yellow[00],
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(3.w, 3.h, 2.w, 0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(top: 0.h, bottom: 2.h),
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
                      Text(
                        "Add Trainee",
                        style: Constants.boldHeading,
                      ),

                      //EMPLOYEE ID
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(labelText: 'Employee Id'),
                          validator: (value) {
                            if (value.isEmpty ||
                                !RegExp(r'^[a-z A-Z 0-9]').hasMatch(value)) {
                              return "Employee ID should contain only text and numbers";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            _employeeId = value;
                          },
                        ),
                      ),

                      //NAME
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value.isEmpty ||
                                !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                              return "enter valid name";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            _traineeName = value;
                          },
                        ),
                      ),

                      //DATE OF JOINING
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 4),
                        child: Bounce(
                          duration: Duration(milliseconds: 110),
                          onPressed: () {
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

                      //QUALIFICATIONS
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          decoration:
                              InputDecoration(labelText: 'Qualifications'),
                          validator: (value) {
                            if (value.isEmpty ||
                                !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                              return "  Enter correct qualifications";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            _traineeQualifications = value;
                          },
                        ),
                      ),

                      //GENDER
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
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
                          validator: (value) =>
                              value == "Gender" ? 'field required' : null,
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

                      //DATE OF Birth
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 4),
                        child: Bounce(
                          duration: Duration(milliseconds: 110),
                          onPressed: () {
                            setState(() {
                              _selectBirthdate(context);
                            });
                          },
                          child: Card(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectBirthdate(context);
                                    });
                                  },
                                  icon: Icon(Icons.calendar_today),
                                ),
                                Text('Date Of Birth: $_formatteBirthdate'),
                              ],
                            ),
                          ),
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
                            onPressed: () async {
                              final isValid = _formKey.currentState.validate();
                              if (DateFormat('dd-MM-yyyy').format(currentBirthDate) == DateFormat('dd-MM-yyyy').format(DateTime.now())) {
                                _showMyDialog("Enter the Date of Birth");
                              }
                              else if (isValid) {
                                print("inside isvalid");
                                await _traineeRef.trainee
                                    .doc(_employeeId)
                                    .get()
                                    .then((DocumentSnapshot snapshot) {
                                  if (snapshot.exists) {
                                    print('im inside snapshot.exists');
                                    Map<String, dynamic> documentData =
                                        snapshot.data();
                                    if (documentData["empId"] != null) {
                                      print('im inside docdata empid');
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                      '$_employeeId already exists. Do you want to overwrite?')
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Overwrite'),
                                                onPressed: () {
                                                  _traineeRef.trainee
                                                      .doc(_employeeId)
                                                      .update({
                                                    // .set({
                                                    'name':
                                                        _traineeName ?? "Null",
                                                    'empId':
                                                        _employeeId ?? "Null",
                                                    'doj': Timestamp.fromDate(
                                                        currentDate),
                                                    'qualifications':
                                                        _traineeQualifications ??
                                                            "Null",
                                                    'gender':
                                                        GenderDropDownValue,
                                                    'age': DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(
                                                                currentBirthDate) ??
                                                        "Null",
                                                    'level': "L0",
                                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DoneMark(
                                                                screen: false,
                                                              )));
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('No'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    print('im inside else 2');
                                    _traineeRef.trainee.doc(_employeeId).set({
                                      'name': _traineeName ?? "Null",
                                      'empId': _employeeId ?? "Null",
                                      'doj': Timestamp.fromDate(currentDate),
                                      'qualifications':
                                          _traineeQualifications ?? "Null",
                                      'gender': GenderDropDownValue,
                                      'age': DateFormat('dd-MM-yyyy')
                                              .format(currentBirthDate) ??
                                          "Null",
                                      'level': "L0",
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DoneMark(
                                                  screen: false,
                                                )));
                                  }
                                });
                              }
                            },
                            child: Text('Submit')),
                      ),
                    ],
                  ),
                ),
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
