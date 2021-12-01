//original
import 'dart:io';
import 'package:ashok_leyland_project_3/Constants.dart';
import 'package:ashok_leyland_project_3/models/card.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:sizer/sizer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:csv/csv.dart';
import 'package:ext_storage/ext_storage.dart';

class OnTheJobTrainingQuery extends StatefulWidget {
  @override
  _OnTheJobTrainingQueryState createState() => _OnTheJobTrainingQueryState();
}

class _OnTheJobTrainingQueryState extends State<OnTheJobTrainingQuery> {
  TextEditingController _searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _traineeName,
      _registerNumber,
      _search,
      _levelDropDownValue,
      _programDropDownValue;
  DateTime _joiningDate;
  DateTime _fromDate = new DateTime.now();
  DateTime _toDate = new DateTime.now();
  Timestamp _fromTimeStamp = Timestamp.fromDate(DateTime.now());
  Timestamp _toTimeStamp = Timestamp.fromDate(DateTime.now());
  List _allResults = [];
  List _searchResults = [];
  List<String> LevelList = ["Select Level", "L0", "L1"];
  List<String> ProgramList = [
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
  Future resultsLoaded;
  List<String> respectiveLevelList = [];
  List<String> respectiveProgramList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_onSearchChanged);
    respectiveLevelList = List.from(LevelList);
    respectiveProgramList = List.from(ProgramList);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    resultsLoaded = getData();
  }

  _onSearchChanged() {
    searchResultsList();
    print(_searchController.text);
  }

  searchResultsList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var item in _allResults) {
        var empId = item["name"].toLowerCase();
        if (empId.contains(_searchController.text.toLowerCase())) {
          showResults.add(item);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _searchResults = showResults;
    });
  }

  var data;
  getData() async {
    print("checking");
    if (_levelDropDownValue != "Select Level") {
      //with level and program case
      if (_programDropDownValue != "Choose Program") {
        if (_fromTimeStamp != null && _toTimeStamp != null) {
          data = await FirebaseFirestore.instance
              .collection("trainee")
              .where("doj", isGreaterThanOrEqualTo: _fromTimeStamp)
              .where("doj", isLessThanOrEqualTo: _toTimeStamp)
              .where("level", isEqualTo: _levelDropDownValue)
              .where("completed Program", arrayContains: _programDropDownValue)
              .get();
          setState(() {
            print("in Set data");
            _allResults = data.docs;
          });
        }
      } else if (_fromTimeStamp != null && _toTimeStamp != null) {
        print("with date");
        data = await FirebaseFirestore.instance
            .collection("trainee")
            .where("doj", isGreaterThanOrEqualTo: _fromTimeStamp)
            .where("doj", isLessThanOrEqualTo: _toTimeStamp)
            .where("level", isEqualTo: _levelDropDownValue)
            .get();
        setState(() {
          print("in Set data");
          _allResults = data.docs;
        });
      } else {
        print("without date");
        data = await FirebaseFirestore.instance
            .collection("trainee")
            .where("level", isEqualTo: _levelDropDownValue)
            .get();
        setState(() {
          print("in Set data");
          _allResults = data.docs;
        });
      }
    } else {
      print("showing everything");
      data = await FirebaseFirestore.instance.collection("trainee").get();
      setState(() {
        print("in Set data");
        _allResults = data.docs;
      });
    }
    searchResultsList();
    return "complete";
  }

  void _generateCsvFile() async {
    // ignore: unused_local_variable
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    List<dynamic> associateList = [
      {"number": 1, "lat": "14.97534313396318", "lon": "101.22998536005622"},
      {"number": 2, "lat": "14.97534313396318", "lon": "101.22998536005622"},
      {"number": 3, "lat": "14.97534313396318", "lon": "101.22998536005622"},
      {"number": 4, "lat": "14.97534313396318", "lon": "101.22998536005622"}
    ];

    List<List<dynamic>> rows = [];

    List<dynamic> row = [];
    row.add("Sno");
    row.add("EmpId");
    row.add("Name");
    row.add("Age");
    rows.add(row);
    for (int i = 0; i < _allResults.length; i++) {
      Map<String, dynamic> data = _allResults[i].data() as Map<String, dynamic>;
      List<dynamic> row = [];
      row.add(i + 1);
      row.add(data["name"]);
      row.add(data["empId"]);
      row.add(data["age"]);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    String dir = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    print("dir $dir");
    String file = "$dir";

    File f = File(file + "/filename.csv");

    f.writeAsString(csv);
    OpenFile.open(file + "/filename.csv");
  }

  @override
  Widget build(BuildContext context) {
    Future<Null> selectFromDate(BuildContext floatcontext) async {
      final DateTime _selFromDate = await showDatePicker(
          context: floatcontext,
          initialDate: _fromDate,
          firstDate: DateTime(1990),
          lastDate: DateTime(3000),
          builder: (context, child) {
            return SingleChildScrollView(
              child: child,
            );
          });
      if (_selFromDate != null && _selFromDate != _fromDate) {
        setState(() {
          _fromDate = _selFromDate;
          _fromTimeStamp = Timestamp.fromDate(_fromDate);
          getData();
        });
      }
    }

    Future<Null> _selectToDate(BuildContext floatcontext) async {
      final DateTime _selToDate = await showDatePicker(
          context: floatcontext,
          initialDate: _toDate,
          firstDate: DateTime(1990),
          lastDate: DateTime(3000),
          builder: (context, child) {
            return SingleChildScrollView(
              child: child,
            );
          });
      if (_selToDate != null && _selToDate != _toDate) {
        setState(() {
          _toDate = _selToDate;
          _toTimeStamp = Timestamp.fromDate(_toDate);
          getData();
        });
      }
    }

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.yellow[00],
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.add),
                  onPressed: () {
                    _generateCsvFile();
                  }),
              body: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(3.w, 3.h, 2.w, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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

                        Center(
                          child: Text(
                            "On The Job Training Query",
                            style: Constants.boldHeading,
                          ),
                        ),

                        //SEARCH BAR
                        Padding(
                          padding: EdgeInsets.fromLTRB(2.h, 3.h, 2.h, 1.h),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 6.h,
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    hintText: "Search",
                                    focusColor: Colors.black,
                                    fillColor: Colors.grey,
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                            ),
                          ),
                        ),

                        //SELECT LEVEL DROPDOWN
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            iconSize: 5.h,
                            focusColor: Colors.red,
                            value: _levelDropDownValue,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),
                            iconEnabledColor: Colors.black,
                            items: respectiveLevelList
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
                            hint: Text(respectiveLevelList[0]),
                            onChanged: (String value) {
                              setState(() {
                                _levelDropDownValue = value;
                                getData();
                              });
                            },
                          ),
                        ),

                        //CHOOSE PROGRAM DROPDOWN
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            iconSize: 5.h,
                            focusColor: Colors.red,
                            value: _programDropDownValue,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),
                            iconEnabledColor: Colors.black,
                            items: respectiveProgramList
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
                            hint: Text(respectiveProgramList[0]),
                            onChanged: (String value) {
                              setState(() {
                                _programDropDownValue = value;
                                getData();
                              });
                            },
                          ),
                        ),

                        //FROM DATEPICKER
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 7, 7, 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectFromDate(context);
                              });
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectFromDate(context);
                                      });
                                    },
                                    icon: Icon(Icons.calendar_today),
                                  ),
                                  Text('From Date : ' +
                                      DateFormat("dd-MM-yyyy")
                                          .format(_fromDate)),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //TO DATEPICKER
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 7, 30),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectToDate(context);
                              });
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // ignore: unnecessary_statements
                                      (() {
                                        _selectToDate(context);
                                      });
                                    },
                                    icon: Icon(Icons.calendar_today),
                                  ),
                                  Text('To Date : ' +
                                      DateFormat("dd-MM-yyyy").format(_toDate)),
                                ],
                              ),
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _searchResults.length ,
                            itemBuilder: (BuildContext context, int index) =>
                                buildCard(context, _searchResults[index]),
                          ),
                        ),
                      ],
                    ),
                  ))));
    });
  }
}
