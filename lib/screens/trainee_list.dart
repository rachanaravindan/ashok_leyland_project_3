import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/screens/trainee_profile.dart';
import 'package:ashok_leyland_project_3/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'select_department_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TraineeList extends StatefulWidget {
  @override
  _traineeListState createState() => _traineeListState();
}

class _traineeListState extends State<TraineeList> {
  // TraineeList traineeListObj = TraineeList();
  @override
  Widget build(BuildContext context) {
    List<String> nameList = [
      "Sneha N",
      "Rachana A",
      "Shrinithi Sellam V P",
      "Sharan Deepak R B",
      "Suravarappu Sai Charan Reddy"
    ];
    List<String> empIDList = [
      "1920510223334455",
      "192050754455666",
      "19205098",
      "19205093",
      "19205110"
    ];
    List<String> joiningDateList = ["13/06/2001", "27/07/2001", "5/03/2002", "12/11/2001","30/02/2002"];
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
                                builder: (context) =>
                                    SelectDepartmentScreen()));
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
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Container(
                  height: 5.h,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        focusColor: Colors.black,
                        fillColor: Colors.grey,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
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

                        onPressed: () {},
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 1.h),
                                child: Icon(Icons.filter_list,
                                    color: Colors.white)),
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
                  Text('Name',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
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
              // ==============================================
              // ListView.builder(itemBuilder: (context, position) {
              //   return Container(

              //     child: Row(
              //       children: [
              //         Text(nameList[position]),
              //         Text(empIDList[position])
              //       ],
              //     ),
              //   );
              // })
              Expanded(
                child: ListView.builder(
                  itemCount: nameList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => traineeProfile(
                                      traineeName: nameList[index],
                                      traineeID: empIDList[index],
                                      joiningDate: joiningDateList[index],
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
                                      nameList[index],
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
                                  empIDList[index],
                                  style: Constants.ListItemSubHeading,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(Icons.add),
              onPressed: () {}),
        ),
      );
    });
  }
}
