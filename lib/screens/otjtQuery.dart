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
// import 'package:ext_storage/ext_storage.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart'
    hide Column, Row, Alignment;
import 'package:synchronized/synchronized.dart';

class OtjtQuery extends StatefulWidget {
  @override
  _OtjtQueryState createState() => _OtjtQueryState();
}

class _OtjtQueryState extends State<OtjtQuery> {
  TextEditingController _searchController = TextEditingController();
  var _operationDescController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _traineeName,
      _registerNumber,
      _search,
      _levelDropDownValue = "Select Level",
      _programDropDownValue;
  bool showToggleBtn = false;
  String departmentDropDownValue = 'Department';
  Map<String, String> _HEngineAssembly = {
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

  Map<String, String> _AEngineAssembly = {
    "10": "Engine Number Punchining and Piston Retainer Fitment",
    "20":
        "PCN,Crank shaft S/A, crank shaft Fitment,crank speed Sensor Fitment & MB cap Tightening",
    "30": "PISTON,CON ROD ASSEMBLY & TORQUE TIGHTENING",
    "40": "Torque to Turn 1 & Quality Gate 1",
    "50": "Pre fitment of Gear Train and Oil pump assy",
    "60": "Gear Train Tightening and Backlash checking",
    "70":
        "Air compressor mtg,FIP Fitment,coolant Temp sensor fitment,Strainer fitment",
    "80":
        "ROS fitment,FWH LSA, FWH,Front mtg bkt,window cover & screw plug Tightening",
    "90": "Fitment of Front cover, Starter motor assy,FW mounting",
    "100":
        "Torque to Turn 2,Damper fitment & Tightening, Front oil seal fitment & Aux bkt fitment",
    "110":
        "Assy of FW brg fitment, Rear dummy bkt fitment,sump assy ang Tightening",
    "120": "Lift and Turn over",
    "130": "Cylinder head mtg,Oilcooler mtg and Tightening",
    "140": "Cylinder Head Bolt Tightening,Camshat SA & fitment",
    "150":
        "Cam idler gear,Trigger wheel,cam speed sensor,Valve train assy,EBS assy,Fuel filter fitment and tightening",
    "160": "Water pump fitment and SET VALVE CLEARANCE",
    "170": "Alternator,Fuel filter,AI maniflold and Metering unit fitment",
    "180": "EGR,Exhaust manifold,Turbo charger fitment",
    "190":
        "Injector and HP connector fitment,CR Fitment,Support piece fitment for internal WH,Internal WH Fitment",
    "200": "EGR hot pipe,Brake Flap S/A & TC Oil inlet & outlet pipe fitment ",
    "210": "HP Pipe & HC Dozer pipe Fitment,Fuel pipes LP fit",
    "220": "Injector Tightening and Fuel Pipes fitment",
    "230": "HC Hozer and EGR Valve coolent pipes fitment",
    "240": "Belt Tensioner,Idler Pulley, Belt Fitment &EGR cold pipe",
    "250":
        "Nox sensor,EGR to Air compressor coolant pipe and rear hook fitment",
    "260":
        "EGR to water pump pipe,Air compressor drain pipe fitment and Cylinder head cover sealant application",
    "270": "Meering unit WH fitment,External WH fitment-RH & Rear side",
    "280": "External WH fitment-LH & front side,ECOS & waterways Leak Test",
    "290": "Quality Gate 2",
    "300": "OIL FILLING",
    "310": "LOADING & UNLOADING",
    "320": "RIGGING",
    "330": "DE RIGGING",
    "340": "ENGINE TEST PERFORMANCE",
    "350": "Quality Gate 3",
    "360": "LOADING & UNLOADING",
    "370": "DRESSING",
    "380": "LACQUERING OF ENGINE",
    "390": "Quality Gate 4",
    "400": "PISTON AND CON ROD SUB-ASSEMBLY",
    "410": "AIR INTAKE SYSTEM SUB-ASSEMBLY",
    "420": "AIR COMPRESSOR SUB ASSY",
    "430": "COMMON RAIL PUMP SUB ASSY",
    "440": "Drive Housing sub assy",
    "450": "Oil cooler Sub assy",
    "460": "FAN SHAFT SUB-ASSEMBLY",
    "470": "CYLINDER HEAD COVER & WH SUB-ASSEMBLY",
    "480":
        "CH Valve assy& leak check,Valve steam seal pressing,Retainer pressing & Oscilation ",
    "490": "CYLINDER BLOCK & Head WASHING",
    "500": "Camshaft & crankshaft washing",
  };
  DateTime _joiningDate;
  DateTime _fromDate = new DateTime.now();
  DateTime _toDate = new DateTime.now();
  Timestamp _fromTimeStamp = Timestamp.fromDate(DateTime.now());
  Timestamp _toTimeStamp = Timestamp.fromDate(DateTime.now());
  List _allResults = [];
  List _searchResults = [];
  List<String> LevelList = ["Select Level", "L2", "L3", "L4"];
  String searchText = "-1";
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
        //var empId = item["name"].toLowerCase();
        var empId = item["empId"];

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
    print(searchText);
    print("checking");
    //Employee number only
    //Department-Level-Operation No
    //Department-Operation No
    //Department-Search
    if ((!searchText.isEmpty &&
            departmentDropDownValue == "Department" &&
            _levelDropDownValue == "Select Level") &&
        (operationNumber == "-1" || operationNumber == null)) {
      print("inside emp only if");
      //Employee Number
      data = await FirebaseFirestore.instance
          .collection("trainee")
          .where("empId", isEqualTo: searchText)
          .where("department", isNull: false)
          .get();
      setState(() {
        _allResults = data.docs;
      });
    } else if ((searchText=="-1"||searchText.isEmpty) &&
        departmentDropDownValue != "Department" &&
        _levelDropDownValue == "Select Level") {
      print("inside department only");
      data = await FirebaseFirestore.instance
          .collection("trainee")
          .where("department", isEqualTo: departmentDropDownValue)
          .get();
      setState(() {
        _allResults = data.docs;
      });
    } else if (searchText.isEmpty && departmentDropDownValue != "Department") {
      print("inside department + level + op no");
      data = await FirebaseFirestore.instance
          .collection("trainee")
          .where(
              "department ${departmentDropDownValue} operation ${operationNumber}",
              isEqualTo: _levelDropDownValue)
          .get();
      setState(() {
        _allResults = data.docs;
      });
    }
    // if (departmentDropDownValue != 'Department') {
    //   if (_levelDropDownValue != "Select Level") {
    //     if (operationNumber != "-1" || operationNumber != null) {
    //       // Department-Level-Operation No
    //       print(
    //           "department ${departmentDropDownValue} operation ${operationNumber}");
    //       data = await FirebaseFirestore.instance
    //           .collection("trainee")
    //           .where(
    //               "department ${departmentDropDownValue} operation ${operationNumber}",
    //               isEqualTo: _levelDropDownValue)
    //           .get();
    //       // data = await FirebaseFirestore.instance
    //       //     .collection("trainee")
    //       //     .where(
    //       //         "department H - Engine Assembly operation 20",
    //       //         isEqualTo: _levelDropDownValue)
    //       //     .get();
    //       setState(() {
    //         print("in Set data");
    //         _allResults = data.docs;
    //       });
    //     }
    //   }
    //   if (operationNumber == "") {
    //     print("inside this if");
    //     //Department
    //     data = await FirebaseFirestore.instance
    //         .collection("trainee")
    //         .where("department", isEqualTo: departmentDropDownValue)
    //         .get();
    //     setState(() {
    //       print("in Set data");
    //       _allResults = data.docs;
    //     });
    //   } else if (_searchController.text != null) {
    //     print("showing everything");
    //     data = await FirebaseFirestore.instance
    //         .collection("trainee")
    //         .doc(_searchController.text)
    //         .collection("completed on the job training")
    //         .where("department $departmentDropDownValue level", isNull: false)
    //         .get();
    //     setState(() {
    //       print("in Set data");
    //       for (int i = 0; i < data.docs.length; i++) {
    //         Map<String, dynamic> data =
    //             _allResults[i].data() as Map<String, dynamic>;
    //         print(data["department $departmentDropDownValue operation no"] +
    //             ":" +
    //             data["department $departmentDropDownValue level"]);
    //       }
    //     });
    //   }
    // }
    searchResultsList();
    return "complete";
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

    // void openExcel(var rows) async {

    //   final Workbook workbook = Workbook();
    //   // Accessing worksheet via index.
    //   final Worksheet sheet = workbook.worksheets[0];
    //   try {
    //     print("Im trying to print it");
    //     for (int i = 1; i <= rows.length; i++) {
    //       for (int j = 1; j <= row.length; j++) {
    //         print(rows[i - 1]);
    //         // sheet.getRangeByIndex(i, j).setText(rows[i - 1][j - 1].toString());
    //       }
    //     }
    //     for (var roww in rows) {
    //       print(roww);
    //     }
    //   } catch (e) {
    //     print("Im not trying to print it");
    //   }
    //   // Set the text value.

    //   sheet.getRangeByIndex(2, 1).setText('Enter a number between 10 and 20');
    //   // Save and dispose the document.
    //   final List<int> bytes = workbook.saveAsStream();
    //   workbook.dispose();

    //   // Get external storage directory
    //   final directory = await getExternalStorageDirectory();

    //   // Get directory path
    //   final path = directory.path;

    //   // Create an empty file to write Excel data
    //   File file = File('$path/Output.xlsx');

    //   // Write Excel data
    //   await file.writeAsBytes(bytes, flush: true);

    //   // Open the Excel document in mobile
    //   OpenFile.open('$path/Output.xlsx');
    // }

    Future<List> iterate(List row, Map<String, String> mapp) async {
      for (int i = 0; i < _allResults.length; i++) {
        Map<String, dynamic> data =
            _allResults[i].data() as Map<String, dynamic>;
        List<dynamic> row = [];
        row.add(i + 1);
        row.add(data["empId"]);
        row.add(data["name"]);
        //row.add(data["department"]);
        row.add("06-12-21");
        mapp.keys.forEach((k) async {
          await FirebaseFirestore.instance
              .collection("trainee")
              .doc(data["empId"])
              .collection("completed on the job training")
              .doc(k.toString())
              .get()
              .then((DocumentSnapshot snapshot) {
            if (snapshot.exists) {
              print("Im in the snapshot.exists");
              Map<String, dynamic> documentData = snapshot.data();
              row.add(
                  documentData["department $departmentDropDownValue level"] ??
                      "Empty");
            } else {
              print("Im in else");
              row.add("Na");
            }
            // print(tempRow);
            // print(row);
          });
        });
      }
    }

    Future<void> _createExcel(Map<String, String> mapp) async {
      final Workbook workbook = Workbook();

// Accessing worksheet via index.
      final Worksheet sheet = workbook.worksheets[0];
      // Create a new Excel Document.
      var lock = new Lock();
      List<List<dynamic>> rows = [];
      List<dynamic> row = [];
      //HEADING
      row.add("Sno");
      row.add("EmpId");
      row.add("Name");
      row.add("Department");
      row.add("Date of Department Allocation");
      if (departmentDropDownValue == "H - Engine Assembly") {
        _HEngineAssembly.keys.forEach((k) {
          row.add("Op $k");
        });
      } else if (departmentDropDownValue == "A - Engine Assembly") {
        _AEngineAssembly.keys.forEach((k) {
          row.add("Op $k");
        });
      }
      rows.add(row);
      for (int i = 0; i < _allResults.length; i++) {
        Map<String, dynamic> data =
            _allResults[i].data() as Map<String, dynamic>;
        List<dynamic> row = [];
        row.add(i + 1);
        row.add(data["empId"]);
        row.add(data["name"]);
        row.add(data["department"]);
        // row.add(data["age"]);
        // row.add(data["gender"]);
        // row.add(data["qualifications"]);
        row.add("07-12-21");
        mapp.keys.forEach((k) {
          if (data["department $departmentDropDownValue operation $k"] != null)
            row.add(data["department $departmentDropDownValue operation $k"]
                .toString());
          else if (k != "-1") row.add("NA");
        });
        rows.add(row);
      }
      print(rows);

      for (int i = 1; i <= rows.length; i++) {
        for (int j = 1; j <= row.length; j++) {
          sheet.getRangeByIndex(i, j).setText(rows[i - 1][j - 1].toString());
        }
      }
      // for (var i in rows) {
      //   print(i);
      // }

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
                    if (departmentDropDownValue == 'A - Engine Assembly')
                      _createExcel(_AEngineAssembly);
                    else if (departmentDropDownValue == 'H - Engine Assembly')
                      _createExcel(_HEngineAssembly);
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
                                  onChanged: (input) {
                                    searchText = input;
                                  },
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
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: DropdownButtonFormField<String>(
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
                              validator: (value) => value == "Department"
                                  ? 'field required'
                                  : null,
                              onChanged: (String value) {
                                setState(() {
                                  departmentDropDownValue = value;
                                  if (value != "department") {
                                    showToggleBtn = true;
                                  } else
                                    showToggleBtn = false;
                                });
                                // getData();
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
                                  //getData();
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
                                  //getData();
                                  print(operationNumber);
                                  try {
                                    if (departmentDropDownValue ==
                                        "H - Engine Assembly") {
                                      if (_HEngineAssembly.containsKey(
                                          operationNumber))
                                        _operationDescController.text =
                                            _HEngineAssembly[operationNumber];
                                      else
                                        _operationDescController.text =
                                            "" ?? "Empty";
                                    }
                                    if (departmentDropDownValue ==
                                        "A - Engine Assembly") {
                                      if (_AEngineAssembly.containsKey(
                                          operationNumber))
                                        _operationDescController.text =
                                            _AEngineAssembly[operationNumber];
                                      else
                                        _operationDescController.text =
                                            "" ?? "Empty";
                                    }
                                  } catch (error) {
                                    print("im in catch");
                                    _operationDescController.text = "";
                                  }
                                });
                                //getData();
                              },
                              decoration: InputDecoration(
                                  labelText: 'Enter Operation Number'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: TextField(
                              controller: _operationDescController,
                              maxLines: 3,
                              enabled: false,
                              decoration: InputDecoration(
                                  labelText: 'Operation Description'),
                            ),
                          ),

                          //SUBMIT BUTTON
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
                                  final isValid =
                                      _formKey.currentState.validate();
                                  getData();
                                },
                                child: Text('Submit')),
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
