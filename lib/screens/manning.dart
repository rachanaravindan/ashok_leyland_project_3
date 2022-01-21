import 'package:altraport/screens/done_add_screen.dart';
import 'package:altraport/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:altraport/constants.dart';
import 'assesment_list_screen.dart';
import 'home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Manning extends StatefulWidget {
  @override
  _ManningState createState() => _ManningState();
}

class _ManningState extends State<Manning> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _statusController = TextEditingController();
  var _deptController = TextEditingController();
  var _operationDescController = TextEditingController();
  crudMethod _traineeRef = new crudMethod();
  bool trainedFinder = false;
  String _traineeName, _employeeId;
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
  DateTime currentDate = new DateTime.now();
  bool _isDisable = false;
  bool showToggleBtn = false, showTextField = false;

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
  Map<String, String> respectiveMap;

  bool valuefirst = false;
  bool valuesecond = false;
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
  String departmentDropDownValue;
  String operationNumber = "-1";
  String assessmentListDropDownValue;
  crudMethod crudOperations = new crudMethod();
  void initState() {
    var departmentDropDownValue = departmentItems[0];
    var assessmentListDropDownValue = assessmentListItems[0];
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

  int _value = 1;

  @override
  Widget build(BuildContext context) {
    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.parse(s, (e) => null) != null;
    }

    String _formattedate = new DateFormat.yMMMd().format(currentDate);

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
              Row(
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Continue'),
                    onPressed: () {
                      trainedFinder = true;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.yellow[00],
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
                    Text(
                      "Manning",
                      style: Constants.boldHeading,
                    ),

                    //EMPLOYEE ID
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onChanged: (input) {
                          _employeeId = input;
                          setState(() async {
                            DocumentSnapshot snapshot = await _traineeRef
                                .trainee
                                .doc(_employeeId)
                                .get();
                            Map<String, dynamic> documentData = snapshot.data();
                            print(documentData["name"] ?? "Null");
                            _nameController.text =
                                documentData["name"] ?? "Null";
                            _deptController.text =
                                documentData["department"] ?? "Null";

                            var value = documentData["department"] ?? "Null";

                            if (value == "Null") {
                              _showMyDialog(
                                  "Department is not allocated for $_employeeId ");
                            }

                            setState(() {
                              departmentDropDownValue = value;
                              if (value == 'H - Engine Assembly')
                                respectiveMap = Map.from(_HEngineAssembly);
                              else if (value == 'A - Engine Assembly')
                                respectiveMap = Map.from(_AEngineAssembly);

                              if (value != "department") {
                                showToggleBtn = true;
                              } else
                                showToggleBtn = false;
                              showTextField = false;
                              // print("Im printing");
                              // print(respectiveMap);
                            });
                          });
                        },
                        decoration: InputDecoration(labelText: 'Employee Id'),
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r'^[a-z A-Z 0-9]').hasMatch(value)) {
                            return "Employee ID should contain only text and numbers";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    //NAME
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
                    //DATE OF TRAINING
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
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
                              Text('Date: $_formattedate'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(2.w),
                      child: Text("Shift",style:Constants.regularHeading),
                    ),
                    Column(
                      children: <Widget>[
                        for (int i = 1; i <= 1; i++)
                          ListTile(
                            title: Text(
                              'FS',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: i == 5
                                          ? Colors.black38
                                          : Colors.black),
                            ),
                            leading: Radio(
                              value: i,
                              groupValue: _value,
                              activeColor: Color(0xFF6200EE),
                              onChanged: i == 5
                                  ? null
                                  : (int value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    },
                            ),
                          ),
                        for (int i = 2; i <= 2; i++)
                          ListTile(
                            title: Text(
                              'MS',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: i == 5
                                          ? Colors.black38
                                          : Colors.black),
                            ),
                            leading: Radio(
                              value: i,
                              groupValue: _value,
                              activeColor: Color(0xFF6200EE),
                              onChanged: i == 5
                                  ? null
                                  : (int value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    },
                            ),
                          ),
                        for (int i = 3; i <= 3; i++)
                          ListTile(
                            title: Text(
                              'NS',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: i == 5
                                          ? Colors.black38
                                          : Colors.black),
                            ),
                            leading: Radio(
                              value: i,
                              groupValue: _value,
                              activeColor: Color(0xFF6200EE),
                              onChanged: i == 5
                                  ? null
                                  : (int value) {
                                      setState(() {
                                        _value = value;
                                        print(value);
                                      });
                                    },
                            ),
                          ),
                      ],
                    ),

                    //OPERATION NUMBER
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onChanged: (input) {
                          setState(() async {
                            operationNumber = input;

                            if (respectiveMap.containsKey(operationNumber))
                              _operationDescController.text =
                                  respectiveMap[operationNumber];
                            else
                              _operationDescController.text = "" ?? "Empty";

                            if (input.isEmpty)
                              _isDisable = true;
                            else
                              _isDisable = false;
                            await _traineeRef.trainee
                                .doc(_employeeId)
                                .collection('completed on the job training')
                                .doc(operationNumber)
                                .get()
                                .then((DocumentSnapshot snapshot) {
                              if (snapshot.exists) {
                                Map<String, dynamic> documentData =
                                    snapshot.data();
                                _statusController.text = "Trained";
                                trainedFinder = true;
                              } else {
                                _statusController.text = "Not Trained";
                                trainedFinder = false;
                              }
                            });
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'Enter Operation Number'),
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r'^[0-9]').hasMatch(value)) {
                            return "Operation Number should contain only numbers";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _operationDescController,
                        maxLines: 3,
                        enabled: false,
                        decoration:
                            InputDecoration(labelText: 'Operation Description'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _statusController,
                        onChanged: (input) {
                          _traineeName = input;
                          setState(() {
                            if (input.isEmpty)
                              _isDisable = true;
                            else
                              _isDisable = false;
                          });
                        },
                        decoration: InputDecoration(labelText: 'Status'),
                        enabled: false,
                        enableInteractiveSelection: true,
                      ),
                    ),
                    //SUBMIT BUTTON
                    Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              shadowColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 2,
                              //color: Colors.amber,

                              padding: EdgeInsets.symmetric(
                                  vertical: 1.5.h, horizontal: 11.6.h),
                              onPrimary: Colors.white // foreground
                              ),
                          onPressed: () async {
                            final isValid = _formKey.currentState.validate();
                            String shift;
                            if (isValid) {
                              if (trainedFinder == false)
                                _showMyDialog(
                                    "$_employeeId is not trained for operation number $operationNumber");
                              else {
                                if (_value == 1) {
                                  shift = "FS";
                                } else if (_value == 1) {
                                  shift = "MS";
                                } else if (_value == 1) {
                                  shift = "NS";
                                }
                                print(currentDate.toString());
                                await FirebaseFirestore.instance
                                    .collection("manning")
                                    .doc(_employeeId.toString() +
                                        " " +
                                        DateFormat("dd-MM-yyyy")
                                            .format(currentDate))
                                    .get()
                                    .then((DocumentSnapshot snapshot) async {
                                  if (snapshot.exists) {
                                    await FirebaseFirestore.instance
                                        .collection("manning")
                                        .doc(_employeeId.toString() +
                                            " " +
                                            DateFormat("dd-MM-yyyy")
                                                .format(currentDate))
                                        .update({
                                      "empId": _employeeId,
                                      "operation no": operationNumber,
                                      "date": Timestamp.fromDate(currentDate),
                                      "name": _nameController.text,
                                      "department": _deptController.text,
                                      "shift": shift
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DoneMark(
                                                  screen: false,
                                                )));
                                  } else {
                                    await FirebaseFirestore.instance
                                        .collection("manning")
                                        .doc(_employeeId.toString() +
                                            " " +
                                            DateFormat("dd-MM-yyyy")
                                                .format(currentDate))
                                        .set({
                                      "empId": _employeeId,
                                      "operation no": operationNumber,
                                      "date": Timestamp.fromDate(currentDate),
                                      "name": _nameController.text,
                                      "department": _deptController.text,
                                      "shift": shift
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
                            }
                          },
                          child: Text('SUBMIT'),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
