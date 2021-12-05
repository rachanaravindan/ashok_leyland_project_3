//original
import 'dart:io';
import 'package:ashok_leyland_project_3/Constants.dart';
import 'package:ashok_leyland_project_3/models/card.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:csv/csv.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart'
    hide Column, Row, Alignment;

class OnTheJobTrainingQuery extends StatefulWidget {
  @override
  _OnTheJobTrainingQueryState createState() => _OnTheJobTrainingQueryState();
}

class _OnTheJobTrainingQueryState extends State<OnTheJobTrainingQuery> {
  TextEditingController _searchController = TextEditingController();
  var _deptController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _traineeName,
      _registerNumber,
      _search,
      _levelDropDownValue = "Select Level",
      _programDropDownValue;
  bool showToggleBtn = false;
  String departmentDropDownValue = 'Department';
  Map<String, String> _operationMap = {
    "-1": "Enter the Operation Number",
    "10": "ENGINE NUMBER PUNCHING AND FITMENT OF PCN & Welsch Plug",
    "20": "SUB ASSY OF CRANK SHAFT",
    "30": "FITMENT OF CRANKSHAFT",
    "40": "CRANKSHAFT TORQUE TIGHTENING",
    "50": "TORQUE TO TURN AND END PLAY CHECKING",
    "60": "FITMENT OF DOWEL AND IDLER SHAFT MOUNTING",
    "70": "FITMENT OF OILPUMP AND TIMING BACK PLATE",
    "80": "SUB ASSY OF CAM SHAFT",
    "90": "FITMENT OF CAM SHAFT AND IDLER GEAR ASSY.",
    "100": "SUB ASSY OF FLYWHEEL HOUSING",
    "110": "SUB ASSY OF FLYWHEEL HOUSING ASSY-LA10704",
    "120": "FITMENT OF FLYWHEEL HOUSING AND TORQUE TIGHTENING",
    "130": "FLYWHEEL HOUSING SEAL PRESSING & LEAK CHECKING",
    "140": "FLYWHEEL MARKING",
    "150": "FITMENT OF FLYWHEEL AND TORQUE TIGHTENING",
    "160": "ENGINE FLIPUP & Starter Motor Stud Fitment",
    "170": "SUB ASSY OF FIP",
    "180": "Fitment FIP",
    "190": "Sub Assy of TG Case",
    "200": "TG case Assy & Tightening",
    "205": "FW bearing fitment,FWH support bkt fitment and Lub oil filling",
    "210": "FITMENT OF DAMPER PULLEY",
    "220": "FITMENT OF LUBE OIL PIPES AND BRACKET",
    "230": "SUB ASSY OF PISTON CON ROD",
    "240": "FITMENT OF PISTON CONROD ASSY ,STRAINER ASSY",
    "250": "CONROD TORQUE TIGHTENING",
    "260": "FWH add on Bolt Tightening & Metacone Bkt Tightening",
    "270": "QG1",
    "280": "Torque to Turn 2-IPV",
    "290": "FITMENT OF SUMP ",
    "300": "TORQUE TIGHTENING OF SUMP FIXING BOLTS",
    "310": "LOAD ENGINE",
    "320": "UNLOAD ENGINE",
    "330": "SUB ASSY OF CYLINDER HEAD",
    "340": "Fitment of Fuel Filter/Bearing Holder/Inline FIP timing setting",
    "350":
        "'Fitment of EGR Cooler bracket/Adaptor, FWH support bracket, HCI Dozer metering unit",
    "360":
        " FITMENT OF DOWELS, TAPPETS, GASKET & CYL HEAD MOUNTING & BOLTS PREFIT ",
    "370":
        "Fitment of Alternator, Coolant elbow, Prefitment of alternator and Inspection Cover ",
    "380": "TORQUE TIGHTENING OF CYLINDER HEAD MTG BOLTS",
    "390": "FITMENT OF ROCKER SHAFT S/A EMF studs fitment & tightening ",
    "395":
        "FITMENT OF EGR cooler,'HC Wiring harness plugging on HC metering unit",
    "400": "FITMENT OF EXHAUST MANIFOLD",
    "410":
        "FITMENT OF THERMOSTAT HSG AND OIL LEVEL GAUGE,Oil separator & breather fitment",
    "415": "EGR cooler fitment,Rocker cover sub assy",
    "420": "Fitment of Oil cooler",
    "430": "TORQUE TIGHTENING ROCKER ADDITIONAL BOLT",
    "440": "TAPPET SETTING ",
    "445": "Oil cooler Tightening",
    "450": "FITMENT OF TURBOCHARGER",
    "460": "FITMENT OF INLET MANIFOLD AND EGR Fitment",
    "470": "Starter Motor Motor Fitment,HC Dozer & EGR pipe fitment",
    "480":
        "'Exhaust Brake S/a fitment - V BAND CLIP AND TIGHT AT SUPPORT BRACKET TORQUE",
    "490": "COMPRESSOR S/A, Rocker cover Oring fitment, Harness Bracket",
    "500": "TAPPET SETTING RECHECKING",
    "510":
        "TIGHTEN OF TURBO OIL INLET PIPE TORQUE ,EGR coolant inlet pipe fitment & 'Blow by outlet hose bracket fitment",
    "520": "Fitment of Injector and scanning",
    "530": "ROCKER COVER SA FITMENT AND TORQUE TIGHTENING AND MARKING",
    "540":
        "'HC dozer fuel inlet pipe fitment (At HC injector end) and torque & mark",
    "550": "Injector clamp Torque  tightening",
    "560":
        "Leak off ppe fitment,'Fuel outlet & inlet pipe fitment & Wiring harness tray stiffner brt fitment",
    "570":
        "Alternator bracket fitment in torque,AC compressor fitment and tightening,FITMENT OF ALTERNATOR WITH LINK BOLT",
    "580": "FITMENT OF INJECTOR PIPES & tighten fuel return pipe",
    "590": "FITMENT OF Injector pipe, HCI coolant return line clip,WH Bracket",
  };
  DateTime _joiningDate;
  DateTime _fromDate = new DateTime.now();
  DateTime _toDate = new DateTime.now();
  Timestamp _fromTimeStamp = Timestamp.fromDate(DateTime.now());
  Timestamp _toTimeStamp = Timestamp.fromDate(DateTime.now());
  List _allResults = [];
  List _searchResults = [];
  List<String> LevelList = ["Select Level", "L2", "L3", "L4"];
  List<String> departmentItems = [
    'Department',
    'Chassis & Frame Assembly',
    'GB Assembly',
    'HT',
    'GB Machining',
    'H - Engine Assembly',
    'Engine - Machining',
    'A - Engine Assembly',
    'A - Engine Machining',
    'Axle Assembly',
    'Axle Machining'
  ];
  Future resultsLoaded;
  List<String> respectiveLevelList = [];
  String operationNumber = "-1";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_onSearchChanged);
    respectiveLevelList = List.from(LevelList);
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
    //Department-Level-Operation No
    //Department-Operation No
    //Department-Search
    if (departmentDropDownValue != 'Department') {
      if (_levelDropDownValue != "Select Level") {
        if (operationNumber != "-1" || operationNumber != null) {
          // Department-Level-Operation No
          print(
              "department ${departmentDropDownValue} operation ${operationNumber}");
          data = await FirebaseFirestore.instance
              .collection("trainee")
              .where(
                  "department ${departmentDropDownValue} operation ${operationNumber}",
                  isEqualTo: _levelDropDownValue)
              .get();
          // data = await FirebaseFirestore.instance
          //     .collection("trainee")
          //     .where(
          //         "department H - Engine Assembly operation 20",
          //         isEqualTo: _levelDropDownValue)
          //     .get();
          setState(() {
            print("in Set data");
            _allResults = data.docs;
          });
        }
      } else if (operationNumber != "-1" || operationNumber != null) {
        //Department-Operation No
        data = await FirebaseFirestore.instance
            .collection("trainee")
            .where(
                "department ${departmentDropDownValue} operation ${operationNumber}",
                isNull: false)
            .get();
        setState(() {
          print("in Set data");
          _allResults = data.docs;
        });
      } else if (_searchController.text != null) {
        print("showing everything");
        data = await FirebaseFirestore.instance
            .collection("trainee")
            .doc(_searchController.text)
            .collection("completed on the job training")
            .where("department $departmentDropDownValue level", isNull: false)
            .get();
        setState(() {
          print("in Set data");
          for (int i = 0; i < data.docs.length; i++) {
            Map<String, dynamic> data =
                _allResults[i].data() as Map<String, dynamic>;
            print(data["department $departmentDropDownValue operation no"] +
                ":" +
                data["department $departmentDropDownValue level"]);
          }
        });
      }
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

    Future<void> _createExcel() async {
// Create a new Excel Document.
      final Workbook workbook = Workbook();

// Accessing worksheet via index.
      final Worksheet sheet = workbook.worksheets[0];
      List<List<dynamic>> rows = [];
      List<dynamic> row = [];
      row.add("Sno");
      row.add("EmpId");
      row.add("Name");
      row.add("Age");
      row.add("Gender");
      row.add("Qualification");
      row.add("Operation Number");
      row.add("Level");
      row.add("Date of completion");
      row.add("Faculty Name");
      row.add("Assesment 1");
      row.add("Assesment 2");
      row.add("Assesment 3");
      row.add("Assesment 4");
      row.add("Assesment 5");
      row.add("Assesment 6");
      row.add("Assesment 7");
      row.add("Assesment 8");
      row.add("Assesment 9");
      row.add("Assesment 10");
      row.add("Assesment 11");
      row.add("Assesment 12");
      row.add("Assesment 13");
      rows.add(row);
      for (int i = 0; i < _allResults.length; i++) {
        Map<String, dynamic> data =
            _allResults[i].data() as Map<String, dynamic>;
        List<dynamic> row = [];
        row.add(i + 1);
        row.add(data["empId"]);
        row.add(data["name"]);
        row.add(data["age"]);
        row.add(data["gender"]);
        row.add(data["qualifications"]);
        row.add(data["operation no"]);
        row.add(data["level"]);
        await FirebaseFirestore.instance
            .collection("trainee")
            .doc(data["empId"])
            .collection("completed on the job training")
            .doc(operationNumber)
            .get()
            .then((DocumentSnapshot snapshot) {
          if (snapshot.exists) {
            print("Im in the snapshot.exists");
            Map<String, dynamic> documentData = snapshot.data();
            print(documentData);
            print(documentData["training"] ?? "Null");
            row.add(documentData["date of completion"].toDate());
            row.add(documentData["faculty name"]);
            for (int i = 0;
                i < documentData["passed assessments"].length;
                i++) {
              if (documentData["passed assessments"][i] == 1)
                row.add("Pass");
              else if (documentData["passed assessments"][i] == 0)
                row.add("Fail");
              else
                row.add("NA");
            }
          }
        });
        print(row);
        rows.add(row);
      }

// Set the text value.
      for (int i = 1; i <= rows.length; i++) {
        for (int j = 1; j <= row.length; j++) {
          sheet.getRangeByIndex(i, j).setText(rows[i - 1][j - 1].toString());
        }
      }

// sheet.getRangeByIndex(2, 1).setText('Enter a number between 10 and 20');
// Save and dispose the document.
      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

// Get external storage directory
      final directory = await getExternalStorageDirectory();

// Get directory path
      final path = directory.path;

// Create an empty file to write Excel data
      File file = File('$path/Output.xlsx');

// Write Excel data
      await file.writeAsBytes(bytes, flush: true);

// Open the Excel document in mobile
      OpenFile.open('$path/Output.xlsx');
    }

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
              // resizeToAvoidBottomInset: false,
              backgroundColor: Colors.yellow[00],
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.blue[300],
                  child: Icon(Icons.file_download),
                  onPressed: () {
                    _createExcel();
                  }),
              body: SingleChildScrollView(
                child: Form(
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
                              "On The Job Training",
                              style: Constants.boldHeading,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Query",
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.h),
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
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                                });
                              },
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
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                          //   child: DropdownButton<String>(
                          //     isExpanded: true,
                          //     dropdownColor: Colors.white,
                          //     iconSize: 5.h,
                          //     focusColor: Colors.red,
                          //     value: _programDropDownValue,
                          //     //elevation: 5,
                          //     style: TextStyle(color: Colors.black),
                          //     iconEnabledColor: Colors.black,
                          //     items: respectiveProgramList
                          //         .map<DropdownMenuItem<String>>((String value) {
                          //       return DropdownMenuItem<String>(
                          //         value: value,
                          //         child: Text(
                          //           value,
                          //           style: TextStyle(
                          //               // color: Colors.black,
                          //               ),
                          //         ),
                          //       );
                          //     }).toList(),
                          //     hint: Text(respectiveProgramList[0]),
                          //     onChanged: (String value) {
                          //       setState(() {
                          //         _programDropDownValue = value;
                          //         getData();
                          //       });
                          //     },
                          //   ),
                          // ),
                          //OPERATION NUMBER
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: TextField(
                              onChanged: (input) {
                                setState(() {
                                  operationNumber = input;
                                  getData();
                                  print(operationNumber);
                                  try {
                                    if (_operationMap
                                        .containsKey(operationNumber))
                                      _deptController.text =
                                          _operationMap[operationNumber];
                                    else
                                      _deptController.text = "" ?? "Empty";
                                  } catch (error) {
                                    print("im in catch");
                                    _deptController.text = "";
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: 'Enter Operation Number'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: TextField(
                              controller: _deptController,
                              maxLines: 3,
                              enabled: false,
                              decoration: InputDecoration(
                                  labelText: 'Operation Description'),
                            ),
                          ),

                          // //FROM DATEPICKER
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(7, 7, 7, 5),
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       setState(() {
                          //         selectFromDate(context);
                          //       });
                          //     },
                          //     child: Card(
                          //       child: Row(
                          //         children: [
                          //           IconButton(
                          //             onPressed: () {
                          //               setState(() {
                          //                 selectFromDate(context);
                          //               });
                          //             },
                          //             icon: Icon(Icons.calendar_today),
                          //           ),
                          //           Text('From Date : ' +
                          //               DateFormat("dd-MM-yyyy")
                          //                   .format(_fromDate)),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          // //TO DATEPICKER
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(7, 0, 7, 30),
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       setState(() {
                          //         _selectToDate(context);
                          //       });
                          //     },
                          //     child: Card(
                          //       child: Row(
                          //         children: [
                          //           IconButton(
                          //             onPressed: () {
                          //               // ignore: unnecessary_statements
                          //               (() {
                          //                 _selectToDate(context);
                          //               });
                          //             },
                          //             icon: Icon(Icons.calendar_today),
                          //           ),
                          //           Text('To Date : ' +
                          //               DateFormat("dd-MM-yyyy")
                          //                   .format(_toDate)),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),

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

                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: _searchResults.length,
                            itemBuilder: (BuildContext context, int index) =>
                                buildCard(context, _searchResults[index]),
                          ),
                        ],
                      ),
                    )),
              )));
    });
  }
}
