import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'trainee_profile.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class MarkAllocationScreen extends StatefulWidget {
  final String traineeName;
  final String traineeID;
  final String joiningDate;

  const MarkAllocationScreen(
      {Key key, this.traineeName, this.traineeID, this.joiningDate})
      : super(key: key);
  @override
  _MarkAllocationScreenState createState() => _MarkAllocationScreenState();
}

@override
// DateTime _joiningDate;
// DateTime currentDate = new DateTime.now();
//bool _isDisable = false;
class _MarkAllocationScreenState extends State<MarkAllocationScreen> {
  DateTime _currentdate = new DateTime.now();
  bool _isDisable = true;
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
  String _traineeName, _employeeId, _traineeQualifications, _traineeAge;
  @override
  void initState() {
    DropDownValue = items[0];
    DayDropDownValue = DayItems[0];
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

    String _formattedate = new DateFormat.yMMMd().format(_currentdate);
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
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
                                builder: (context) => traineeProfile(
                                      traineeID: widget.traineeID,
                                      traineeName: widget.traineeName,
                                      joiningDate: widget.joiningDate,
                                    )));
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 120),
                child: Text(
                  'SDC Training',
                  style: Constants.boldHeading,
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
                  value: DayDropDownValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),
                  iconEnabledColor: Colors.black,
                  items: DayItems.map<DropdownMenuItem<String>>((String value) {
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
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  iconSize: 5.h,
                  focusColor: Colors.red,
                  value: DropDownValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),
                  iconEnabledColor: Colors.black,
                  items: items.map<DropdownMenuItem<String>>((String value) {
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
                padding: const EdgeInsets.only(right: 200),
                child: Container(
                    height: 5.h,
                    child: showToggleBtn == true
                        ? ToggleButtons(
                            selectedBorderColor: Colors.black,
                            borderColor: Colors.black,
                            borderWidth: 0.2.h,
                            borderRadius: BorderRadius.circular(0.5.h),
                            isSelected: isSelected2,
                            fillColor: Colors.blue,
                            selectedColor: Colors.white,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Pre-Test"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Post-Test"),
                              ),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                if (index == 0 || index == 1)
                                  showTextField = true;
                                for (int buttonIndex = 0;
                                    buttonIndex < isSelected2.length;
                                    buttonIndex++) {
                                  if (buttonIndex == index) {
                                    isSelected2[buttonIndex] = true;
                                  } else {
                                    isSelected2[buttonIndex] = false;
                                  }
                                }
                              });
                            },
                          )
                        : null),
              ),
              if (showTextField)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Enter Marks'),
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
                    onPressed: _isDisable
                        ? null
                        : () {
                            print("Submitted");
                          },
                    child: Text('Submit')),
              ),
            ],
          ),
        ),
      ));
    });
  }
}
