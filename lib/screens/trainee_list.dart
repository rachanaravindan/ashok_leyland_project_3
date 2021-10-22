import 'package:ashok_leyland_project_3/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'select_department_screen.dart';
import 'package:sizer/sizer.dart';

class traineeList extends StatefulWidget {
  @override
  _traineeListState createState() => _traineeListState();
}

class _traineeListState extends State<traineeList> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectDepartmentScreen()));
                },
                child: Container(
                  margin: EdgeInsets.all(3.h),
                  height:7.0.h,
                  width: 7.0.h,
                  child: Icon(Icons.arrow_back),
                  decoration: BoxDecoration(
                    
                      shape: BoxShape.circle,
                      color: HexColor("#F3F3F3"),
                      boxShadow: [
                        BoxShadow(blurRadius: .5.h),
                      ]),
                  // child: ElevatedButton(
                  //     onPressed: () {
                  //       print('sharan is a good boy');
                  //     },
                  // child: Icon(Icons.arrow_back_ios_new_sharp),
                  // ),
                ),
              ),
              TextField(
                  
                decoration: InputDecoration(
                  prefixIcon:  Icon(Icons.search),
                  border: OutlineInputBorder()
                ),
              ),
              Container(
                
              )
            ],
          ),
        ),
      );
    });
  }
}
