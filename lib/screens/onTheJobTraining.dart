import 'package:ashok_leyland_project_3/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:ashok_leyland_project_3/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class OnTheJobTraining extends StatefulWidget {
  @override
  _OnTheJobTrainingState createState() => _OnTheJobTrainingState();
}

class _OnTheJobTrainingState extends State<OnTheJobTraining> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _traineeName, _employeeId, _facultyName;
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
  DateTime currentDate = new DateTime.now();
  bool _isDisable = false;
  bool showToggleBtn = false, showTextField = false;
  List<String> departmentItems = [
    'Department',
    'Chassis & Frame Assembly',
    'GB Assembly',
    'HT'
  ];
  List<String> operationUnitItems1 = [
    'Operation',
    '10- Engine Number Punching And Fitment Of PCN & Welsch Plug ',
    '20- Sub Assy Of Crank Shaft',
    '30- Fitment Of Crank Shaft',
    '40- Crank Shaft Torque Tightening',
    '50- Torque To Turn And End Play Checking',
    '60- Fitment Of Dowel And Idler Shaft Mounting'
  ];
  List<String> operationUnitItems2 = [
    'Chassis & Frame Assembly',
    'Operation',
    '10- Engine Number Punching And Fitment Of PCN & Welsch Plug ',
    '20- Sub Assy Of Crank Shaft',
    '30- Fitment Of Crank Shaft',
    '40- Crank Shaft Torque Tightening',
    '50- Torque To Turn And End Play Checking',
    '60- Fitment Of Dowel And Idler Shaft Mounting'
  ];
  List<String> operationUnitItems3 = [
    'GB Assembly',
    'Operation',
    '10- Engine Number Punching And Fitment Of PCN & Welsch Plug ',
    '20- Sub Assy Of Crank Shaft',
    '30- Fitment Of Crank Shaft',
    '40- Crank Shaft Torque Tightening',
    '50- Torque To Turn And End Play Checking',
    '60- Fitment Of Dowel And Idler Shaft Mounting'
  ];
  List<String> operationUnitItems4 = [
    'HT',
    'Operation',
    '10- Engine Number Punching And Fitment Of PCN & Welsch Plug ',
    '20- Sub Assy Of Crank Shaft',
    '30- Fitment Of Crank Shaft',
    '40- Crank Shaft Torque Tightening',
    '50- Torque To Turn And End Play Checking',
    '60- Fitment Of Dowel And Idler Shaft Mounting'
  ];
  List<String> respectiveDropDown = ['Assessment List'];
  List<String> assessmentListItems = [
    'Assessment List',
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
                    "On The Job Training",
                    style: Constants.boldHeading,
                  ),

                  //EMPLOYEE ID
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

                  //NAME
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

                  //DEPARTMENT
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
                          if (value == 'Chassis & Frame Assembly')
                            respectiveDropDown = List.from(operationUnitItems1);
                          else if (value == 'GB Assembly')
                            respectiveDropDown = List.from(operationUnitItems2);
                          else if (value == 'HT')
                            respectiveDropDown = List.from(operationUnitItems3);

                          if (value != "department") {
                            showToggleBtn = true;
                          } else
                            showToggleBtn = false;
                          showTextField = false;
                        });
                      },
                    ),
                  ),

                  //OPERATION NUMBER
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (input) {
                        setState(() {
                          operationNumber = input;
                          print(_operationMap[operationNumber]);
                          if (input.isEmpty)
                            _isDisable = true;
                          else
                            _isDisable = false;
                        });
                      },
                      decoration:
                          InputDecoration(labelText: 'Operation Number'),
                    ),
                  ),
                  (operationNumber != null)
                      ? Text("Operation Description" +
                              _operationMap[operationNumber.toString()] ??
                          "Enter Operation Number")
                      : null,

                  //DATE OF TRAINING
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
                            Text('Date Of Training: $_formattedate'),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //FACULTY NAME
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (input) {
                        _facultyName = input;
                        setState(() {
                          if (input.isEmpty)
                            _isDisable = true;
                          else
                            _isDisable = false;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Faculty Name'),
                    ),
                  ),

                  //ASSESSMENT LIST
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconSize: 5.h,
                      focusColor: Colors.red,
                      value: assessmentListDropDownValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      iconEnabledColor: Colors.black,
                      items: assessmentListItems
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
                      hint: Text(assessmentListItems[0]),
                      onChanged: (String value) {
                        setState(() {
                          assessmentListDropDownValue = value;
                          if (value != "assessmentList") {
                            showToggleBtn = true;
                          } else
                            showToggleBtn = false;
                          showTextField = false;
                        });
                      },
                    ),
                  ),

                  //BUTTON
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
                          crudOperations.storeData({});
                        },
                        child: Text('PROMOTE')),
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
