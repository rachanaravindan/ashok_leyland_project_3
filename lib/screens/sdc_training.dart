import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:ashok_leyland_project_3/services/crud.dart';
import 'package:ashok_leyland_project_3/widgets/custom_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:sizer/sizer.dart';
import 'done_add_screen.dart';
import 'trainee_profile.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class SdcTrainingScreen extends StatefulWidget {
  final String traineeName;
  final String traineeID;
  final String joiningDate;

  const SdcTrainingScreen(
      {Key key, this.traineeName, this.traineeID, this.joiningDate})
      : super(key: key);
  @override
  _SdcTrainingScreenState createState() => _SdcTrainingScreenState();
}

@override
// DateTime _joiningDate;
// DateTime currentDate = new DateTime.now();
//bool _isDisable = false;
double entered_pretest_mark = 0;
double entered_posttest_mark = 0;
double max_marks = 0;

class _SdcTrainingScreenState extends State<SdcTrainingScreen> {
  var _nameController = TextEditingController();
  var _pretestPercentage = TextEditingController();
  var _posttestPercentage = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _currentdate = new DateTime.now();
  bool _isDisable = true;
  crudMethod _traineeRef = new crudMethod();
  DateTime currentDate = new DateTime.now();
  double _preTestMarks = -1, _postTestMarks = -1, index = -1;
  Future<Null> _selectdate(BuildContext floatcontext) async {
    final DateTime _seldate = await showDatePicker(
        context: floatcontext,
        initialDate: _currentdate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_seldate != null && _seldate != _currentdate) {
      setState(() {
        _currentdate = _seldate;
      });
    }
  }

  List<bool> isSelected2 = [false, false];
  bool showToggleBtn = false, showTextField = false;
  List<String> items = [
    'Choose Program',
    'Ashok Leyland Overview',
    'Basics of Automobile',
    'Safety',
    'Cognitive',
    'Dexterity',
    'Parts Identification',
    'Work Ethics and Standing Orders',
    '5S, Gemba & TQM'
  ];
  List<String> DayItems = [
    'Training Day',
    'Day 1',
    'Day 2',
    'Day 3',
    'Day 4',
    'Day 5',
    'Day 6'
  ];
  String DropDownValue, ToggleBtnVal, DayDropDownValue;
  String _traineeName,
      _employeeId,
      _traineeQualifications,
      _traineeAge,
      _name,
      _mentorName;
  @override
  void initState() {
    DropDownValue = items[0];
    DayDropDownValue = DayItems[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(String error) async {
      print("Im Pressed");
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

    Future<void> _showMyHomeDialog(String error) async {
      print("Im Pressed");
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ],
          );
        },
      );
    }

    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.parse(s, (e) => null) != null;
    }

    String _formattedate = new DateFormat.yMMMd().format(_currentdate);
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            if (widget.traineeName != null)
                              print(widget.traineeName);
                            else
                              print('null');
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
                        'SDC Training',
                        style: Constants.boldHeading,
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        onChanged: (input) {
                          _employeeId = input;
                          setState(() async {
                            await _traineeRef.trainee
                                .doc(_employeeId)
                                .get()
                                .then((DocumentSnapshot snapshot) {
                              if (snapshot.exists) {
                                Map<String, dynamic> documentData =
                                    snapshot.data();
                                print(documentData["name"] ?? "Null");
                                _nameController.text =
                                    documentData["name"] ?? "Null";
                              } else {
                                _nameController.text =
                                    "Enter Valid Employee ID";
                              }
                            });
                          });
                        },
                        decoration: InputDecoration(labelText: 'Employee Id'),
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r'^[a-z A-Z 0-9]').hasMatch(value)) {
                            return "Employee ID should only contain text and numbers";
                          } else {
                            return null;
                          }
                        }),
                  ),

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
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconSize: 5.h,
                      focusColor: Colors.red,
                      value: DayDropDownValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      iconEnabledColor: Colors.black,
                      items: DayItems.map<DropdownMenuItem<String>>(
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
                      hint: Text(DayItems[0]),
                      validator: (value) =>
                          value == "Training Day" ? 'field required' : null,
                      onChanged: (String value) {
                        setState(() {
                          DayDropDownValue = value;
                          if (value != "Training Day") {
                            showToggleBtn = true;
                          } else
                            showToggleBtn = false;
                          showTextField = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _selectdate(context);
                      },
                      child: Card(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _selectdate(context);
                              },
                              icon: Icon(Icons.calendar_today),
                            ),
                            Text('Date: $_formattedate '),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconSize: 5.h,
                      focusColor: Colors.red,
                      value: DropDownValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      iconEnabledColor: Colors.black,
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
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
                      hint: Text(items[0]),
                      validator: (value) =>
                          value == "Choose Program" ? 'field required' : null,
                      onChanged: (String value) {
                        setState(() {
                          DropDownValue = value;
                          if (value != "Choose Program") {
                            showToggleBtn = true;
                          } else
                            showToggleBtn = false;
                          showTextField = false;
                        });
                      },
                    ),
                  ),
                  // AnimatedPadding(
                  //   duration: const Duration(seconds: 10),
                  //   curve: Curves.easeInOut,
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: DropdownButton<String>(
                  //     isExpanded: true,
                  //     dropdownColor: Colors.white,
                  //     iconSize: 5.h,
                  //     focusColor: Colors.red,
                  //     value: DropDownValue,
                  //     //elevation: 5,
                  //     style: TextStyle(color: Colors.black),
                  //     iconEnabledColor: Colors.black,
                  //     items: items.map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(
                  //           value,
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //       );
                  //     }).toList(),
                  //     hint: Text(items[0]),
                  //     onChanged: (String value) {
                  //       setState(() {
                  //         DropDownValue = value;
                  //         if (value != "Select any One") {
                  //           showToggleBtn = true;
                  //         } else
                  //           showToggleBtn = false;
                  //         showTextField = false;
                  //       });
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                        onChanged: (str) {
                          setState(() {
                            if (str.isEmpty) _isDisable = true;
                            _mentorName = str;
                          });
                        },
                        decoration: InputDecoration(labelText: 'Trainer Name'),
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                            return "Enter correct trainee name";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                        onChanged: (str) {
                          setState(() {
                            if (str.isEmpty)
                              _isDisable = true;
                            else if (isNumeric(str)) _isDisable = false;
                            max_marks = double.tryParse(str) ?? -1;
                          });
                        },
                        decoration: InputDecoration(labelText: 'Maximum Marks'),
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r'^[0-9]').hasMatch(value)) {
                            return "Enter maximum marks";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                        onChanged: (str) {
                          setState(() {
                            if (str.isEmpty)
                              _isDisable = true;
                            else if (isNumeric(str)) _isDisable = false;
                            entered_pretest_mark = double.tryParse(str) ?? -1;
                            if (entered_pretest_mark != null &&
                                max_marks != null) {
                              _pretestPercentage.text =
                                  ((entered_pretest_mark / max_marks) * 100)
                                      .toString();
                            }
                          });
                        },
                        decoration:
                            InputDecoration(labelText: 'Enter Pre-Test Marks'),
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r'^[0-9]').hasMatch(value)) {
                            return "Enter correct pre-test marks";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: _pretestPercentage,
                      enabled: false,
                      decoration:
                          InputDecoration(labelText: 'Percentage (Pre-Test)'),
                      onChanged: (str) {
                        setState(() {
                          if (str.isEmpty)
                            _isDisable = true;
                          else if (isNumeric(str)) _isDisable = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty ||
                            !RegExp(r'^[0-9]').hasMatch(value)) {
                          return "Enter correct post-test marks";
                        } else {
                          return null;
                        }
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter Post-Test Marks'),
                      onChanged: (str) {
                        setState(() {
                          if (str.isEmpty)
                            _isDisable = true;
                          else if (isNumeric(str)) _isDisable = false;
                          entered_posttest_mark = double.tryParse(str) ?? -1;
                          if (entered_posttest_mark != null &&
                              max_marks != null) {
                            _posttestPercentage.text =
                                ((entered_posttest_mark / max_marks) * 100)
                                    .toString();
                          }
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: _posttestPercentage,
                      enabled: false,
                      decoration:
                          InputDecoration(labelText: 'Percentage (Post-Test)'),
                      onChanged: (str) {
                        setState(() {
                          if (str.isEmpty)
                            _isDisable = true;
                          else if (isNumeric(str)) _isDisable = false;
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
                            final isValid = _formKey.currentState.validate();
                            if (isValid) {
                              _preTestMarks =
                                  ((entered_pretest_mark / max_marks) * 100);
                              _postTestMarks =
                                  ((entered_posttest_mark / max_marks) * 100);
                              if (_preTestMarks == -1 || _postTestMarks == -1) {
                                _showMyDialog("Invalid Mark");
                              }
                              print('entered pretest marks ' +
                                  entered_pretest_mark.toString());
                              print('entered posttest marks ' +
                                  entered_posttest_mark.toString());
                              if (entered_pretest_mark > max_marks) {
                                _showMyDialog(
                                    "Pretest mark exceeds maximum mark");
                              } else if (entered_posttest_mark > max_marks) {
                                _showMyDialog(
                                    "Posttest mark exceeds maximum mark");
                              } else {

                                if (_nameController.text ==
                                    "Enter Valid Employee ID") {
                                  _showMyHomeDialog("Enter Valid Employee ID");
                                } else {
                                  _traineeRef.trainee
                                      .doc(_employeeId)
                                      .collection("completed training")
                                      .doc(DropDownValue)
                                      .set({
                                    "day": DayDropDownValue,
                                    DropDownValue: true,
                                    "pre_test_marks": _preTestMarks,
                                    "post_test_marks": _postTestMarks,
                                    "date of completion":
                                        DateFormat("dd-MM-yyyy")
                                            .format(currentDate),
                                    "training": DropDownValue,
                                    "mentor name": _mentorName,
                                  });
                                  _traineeRef.trainee.doc(_employeeId).update({
                                    "completed Program": FieldValue.arrayUnion(
                                            [DropDownValue]) ??
                                        "Empty",
                                    "date of completion of ${DropDownValue}":
                                        Timestamp.fromDate(_currentdate)
                                  });
                                  _traineeRef.trainee
                                      .doc(_employeeId)
                                      .get()
                                      .then((DocumentSnapshot snapshot) {
                                    if (snapshot.exists) {
                                      Map<String, dynamic> documentData =
                                          snapshot.data();
                                      if (documentData["completed Program"]
                                              .length ==
                                          8) {
                                        _traineeRef.trainee
                                            .doc(_employeeId)
                                            .update({
                                          "level": "L1"
                                        });
                                      }
                                    }
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DoneMark(
                                                screen: false,
                                              )));
                                }

                              }
                            }
                          },
                          child: Text('Submit'))),
                ],
              ),
            ),
          ),
        ),
      ));
    });
  }
}