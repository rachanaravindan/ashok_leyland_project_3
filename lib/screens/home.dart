import 'package:ashok_leyland_project_3/screens/add_trainee.dart';
import 'package:ashok_leyland_project_3/screens/sdc_training.dart';
import 'package:ashok_leyland_project_3/screens/trainee_list.dart';
import 'package:ashok_leyland_project_3/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ashok_leyland_project_3/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_bar.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService _authService = AuthService();
  Container departmentButton(
      String deptName, double heightVar, double widthVar, int screen) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              primary: Colors.amber, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              switch (screen) {
                case 1:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTrainee()));
                  break;
                case 2:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SdcTrainingScreen()));
                  break;
                case 3:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TraineeList()));
                  break;
                default:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TraineeList()));
                  break; 
              }
            },
            child: Container(
              height: heightVar,
              width: widthVar,
              child: Icon(
                Icons.engineering,
              ),
              padding: EdgeInsets.symmetric(vertical: 55, horizontal: 5),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            deptName,
            style: Constants.regularDarkText,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 20.0, 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      _authService.signOut();
                    },
                    child: Icon(Icons.logout_outlined),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0.h),
                child: Center(
                  child: Text('Home',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      )),
                ),
              ),
              Container(
                height: 10,

                // child: Demo(), //search bar
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 25),
                child: Wrap(
                  spacing: 30,
                  runSpacing: 40,
                  alignment: WrapAlignment.start,
                  children: [
                    departmentButton('Add Trainee', 15.0.h, 15.0.h, 1),
                    departmentButton('SDC Training', 15.0.h, 15.0.h, 2),
                    departmentButton('SDC Query', 15.0.h, 15.0.h, 3),
                    departmentButton(
                        'Department \n Allocation', 15.0.h, 15.0.h, 4),
                    departmentButton(
                        'On the job \n Training', 15.0.h, 15.0.h, 5),
                    departmentButton(
                        'On the job \n Training \n Query', 15.0.h, 15.0.h, 6),
                  ],
                ),
              ),
            ],
          ),
        )),
      );
    });
  }
}
