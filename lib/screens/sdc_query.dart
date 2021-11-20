import 'package:ashok_leyland_project_3/Constants.dart';
import 'package:ashok_leyland_project_3/my_fav_animations/loading.dart';
import 'package:ashok_leyland_project_3/screens/add_trainee.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:ashok_leyland_project_3/screens/trainee_profile.dart';
import 'package:ashok_leyland_project_3/widgets/custom_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SdcQuery extends StatefulWidget {
  final bool isLevelQuery;

  const SdcQuery({Key key, this.isLevelQuery}) : super(key: key);
  @override
  _SdcQueryState createState() => _SdcQueryState();
}

class _SdcQueryState extends State<SdcQuery> {
  final _formKey = GlobalKey<FormState>();
  String _traineeName,
      _registerNumber,
      _search,
      _dropDownValue = "Select Level";
  DateTime _joiningDate;
  DateTime _fromDate = new DateTime.now();
  DateTime _toDate = new DateTime.now();
  Timestamp _fromTimeStamp = Timestamp.fromDate(DateTime.now());
  Timestamp _toTimeStamp = Timestamp.fromDate(DateTime.now());
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
  List<String> respectiveList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isLevelQuery)
      respectiveList = List.from(LevelList);
    else
      respectiveList = List.from(ProgramList);
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
        });
      }
    }

    Stream<QuerySnapshot> getData(BuildContext context) async* {
      if (_dropDownValue != "Select Level") {
        if (_fromTimeStamp != null && _toTimeStamp != null) {
          yield* FirebaseFirestore.instance
              .collection("trainee")
              .where("doj", isGreaterThanOrEqualTo: _fromTimeStamp)
              .where("doj", isLessThanOrEqualTo: _toTimeStamp)
              .where("level",isEqualTo: _dropDownValue)
              .snapshots();
        } else {
          yield* FirebaseFirestore.instance
              .collection("trainee")
              .where("level", isEqualTo: _dropDownValue)
              .snapshots();
        }
      } else
        yield* FirebaseFirestore.instance.collection("trainee").snapshots();
    }

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
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
                Text(
                  'Trainee Details',
                  style: Constants.ListItemHeading,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Colors.white,
                iconSize: 5.h,
                focusColor: Colors.red,
                value: _dropDownValue,
                //elevation: 5,
                style: TextStyle(color: Colors.black),
                iconEnabledColor: Colors.black,
                items: respectiveList
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
                hint: Text(respectiveList[0]),
                onChanged: (String value) {
                  setState(() {
                    _dropDownValue = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
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
                          DateFormat("dd-MM-yyyy").format(_fromDate)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 6.h,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                        hintText: "Search",
                        focusColor: Colors.black,
                        fillColor: Colors.grey,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(5.w, 3.w, 1.w, 1.w),
                child: Row(
                  children: [
                    ElevatedButton(
                      // style: ElevatedButton.styleFrom(
                      //     // primary: HexColor("#F3F3F3"))

                      onPressed: () {
                        print("im pressed");
                      },
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 1.h),
                              child:
                                  Icon(Icons.filter_list, color: Colors.white)),
                          Text(
                            'Filter',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
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
                child: StreamBuilder<QuerySnapshot>(
              stream: getData(context),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                }

                return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => traineeProfile(
                                      traineeName: data["name"] ??= "null",
                                      traineeID: data["empId"] ??= "null",
                                      joiningDate: data["doj"].toDate().toString(),
                                    )));
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 2.w),
                        color: HexColor("#D9E9F2"),
                        elevation: 0.5.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Center(
                              child: Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                              )),
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(5.w, 0, 0, 1.2.h),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      data["name"] ??= "null",
                                      style: Constants.ListItemHeading,
                                    ),
                                  ),
                                )),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.fromLTRB(12.w, 0, 0, 1.2.h),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  data["empId"] ??= "null",
                                  style: Constants.ListItemSubHeading,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTrainee()));
            }),
      ));
    });
  }
}
