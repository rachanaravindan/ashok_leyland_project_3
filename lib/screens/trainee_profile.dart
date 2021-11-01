import 'package:ashok_leyland_project_3/constants.dart';
import 'package:ashok_leyland_project_3/screens/mark_allocation.dart';
import 'package:ashok_leyland_project_3/screens/select_department_screen.dart';
import 'package:ashok_leyland_project_3/screens/temp_screen_delete_it.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'trainee_list.dart';

class traineeProfile extends StatefulWidget {
  final String traineeName;
  final String traineeID;
  final String joiningDate;

  const traineeProfile(
      {Key key, this.traineeName, this.traineeID, this.joiningDate})
      : super(key: key);

  @override
  _traineeProfileState createState() => _traineeProfileState();
}

class _traineeProfileState extends State<traineeProfile> {
  List<String> testNumber = ["T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8"];
  List<int> preTest = [45, 56, 67, 86, 45, 34, 90, 67];
  List<int> postTest = [45, 56, 67, 86, 45, 34, 90, 67];

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
                backgroundColor: HexColor("#D9E9F2"),
                body: Column(
          children: [
            // BACK ARROW==================================================
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TraineeList()));
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
            // CIRCLE AVATAR==============================================
            Container(
              child: Expanded(
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.only(left: 2.h, top: 2.h),
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        child: Icon(Icons.person,size: 7.h,color: Colors.white,),
                        radius: 5.h,
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 3.h, top: 1.h),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.traineeName,
                      style: TextStyle(
                          fontSize: 3.h,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 3.h, top: 1.h),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Employee Id :  ' + widget.traineeID,
                      style: Constants.ListItemSubHeading,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 3.h, top: 1.h),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Joining Date :  ' + widget.joiningDate,
                      style: Constants.ListItemSubHeading,
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
          
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('Tests'),
                      )),
                      Expanded(child: Text('Pre Test')),
                      Expanded(child: Text('Post Test')),
                    ],
                  ),
          
                  // listview starting=====================================================
                  Expanded(
                    child: ListView.builder(
                        //  physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: testNumber.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: postTest[index] < 50
                                ? Colors.red.shade400
                                : Colors.green,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(0.8.h),
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: 0.5.h, horizontal: 3.w),
                            //  color: HexColor("#D9E9F2"),
                            elevation: 0.7.h,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      testNumber[index],
                                      style: Constants.ListItemSubHeading,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  preTest[index].toString(),
                                  style: Constants.ListItemSubHeading,
                                )),
                                Expanded(
                                    child: Text(
                                  postTest[index].toString(),
                                  style: Constants.ListItemSubHeading,
                                ))
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5.h, horizontal: 13.h),
          
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MarkAllocationScreen(
                                       traineeID: widget.traineeID,
                                      traineeName: widget.traineeName,
                                      joiningDate: widget.joiningDate,
                                    )));
          
                      },
                      child: Text('Marks Allocation')),
                  SizedBox(
                    height: 1.h,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5.h, horizontal: 13.8.h),
          
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {},
                      child: Text('Unit Allocation')),
                  SizedBox(
                    height: 1.h,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
          
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5.h, horizontal: 11.6.h),
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {},
                      child: Text('Program Evaluation')),
                  SizedBox(
                    height: 1.h,
                  ),
                ]),
              ),
            ),
          ],
                ),
              ));
    });
  }
}
