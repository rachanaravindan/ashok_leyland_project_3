//original
import 'dart:io';

import 'package:ashok_leyland_project_3/Constants.dart';
import 'package:ashok_leyland_project_3/models/card.dart';
import 'package:ashok_leyland_project_3/my_fav_animations/loading.dart';
import 'package:ashok_leyland_project_3/screens/add_trainee.dart';
import 'package:ashok_leyland_project_3/screens/home.dart';
import 'package:ashok_leyland_project_3/screens/trainee_profile.dart';
import 'package:ashok_leyland_project_3/widgets/custom_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:csv/csv.dart';
import 'package:ext_storage/ext_storage.dart';

class Promotion extends StatefulWidget {
  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
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

  Future resultsLoaded;
  List<String> respectiveLevelList = [];
  List<String> respectiveProgramList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_onSearchChanged);
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
        var empId = item["empId"].toLowerCase();
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
    data = await FirebaseFirestore.instance.collection("trainee").get();
    setState(() {
      _allResults = data.docs;
    });

    searchResultsList();
    return "complete";
  }

  void _generateCsvFile() async {
    // ignore: unused_local_variable
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

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

                        Text(
                          "Promotion Screen",
                          style: Constants.boldHeading,
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
                            itemCount: _searchResults.length,
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
