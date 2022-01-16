import 'package:ashok_leyland_project_3/screens/add_trainee.dart';
import 'package:ashok_leyland_project_3/screens/deleteTrainee.dart';
import 'package:ashok_leyland_project_3/screens/manning.dart';
import 'package:ashok_leyland_project_3/screens/manning_query.dart';
// import 'package:ashok_leyland_project_3/screens/manningQuery.dart';
import 'package:ashok_leyland_project_3/screens/otjtQuery.dart';
import 'package:ashok_leyland_project_3/widgets/exit_popup.dart';
import 'package:ashok_leyland_project_3/screens/on_the_job_training_query.dart';
import 'package:ashok_leyland_project_3/screens/promotion.dart';
import 'package:ashok_leyland_project_3/screens/sdc_training.dart';
import 'package:ashok_leyland_project_3/screens/department_allocation.dart';
import 'package:ashok_leyland_project_3/screens/onTheJobTraining.dart';
import 'package:ashok_leyland_project_3/screens/sdc_query.dart';
import 'package:ashok_leyland_project_3/screens/signin_page.dart';
import 'package:ashok_leyland_project_3/services/auth.dart';
import 'package:ashok_leyland_project_3/widgets/exit_popup.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ashok_leyland_project_3/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'search_bar.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime timeBackPressed = DateTime.now();
  AuthService _authService = AuthService();
  String assetLoc;
  void setAssetName(int screen) {
    switch (screen) {
      case 1:
        assetLoc = "assets/Add_trainee.svg";
        break;
      case 2:
        assetLoc = "assets/SDC_Training.svg";
        break;
      case 3:
        assetLoc = "assets/Query.svg";
        break;
      case 4:
        assetLoc = "assets/department-allocation.svg";
        break;
      case 5:
        assetLoc = "assets/onthejobbb.svg";
        break;
      case 6:
        assetLoc = "assets/on_the_job_query.svg";
        break;
      case 7:
        assetLoc = "assets/promotion.svg";
        break;
      case 8:
        assetLoc = "assets/manning.svg";
        break;
      case 9:
        assetLoc = "assets/manningQuery.svg";
        break;
      default:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SdcQuery()));
        break;
    }
  }

  Container departmentButton(
      String deptName, double heightVar, double widthVar, int screen) {
    setAssetName(screen);
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              primary: Colors.amber.shade400, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              switch (screen) {
                case 1:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTrainee()));
                  assetLoc = "assets/Add_trainee.svg";
                  break;
                case 2:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SdcTrainingScreen()));
                  assetLoc = "assets/SDC_Training.svg";
                  break;
                case 3:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SdcQuery()));
                  assetLoc = "assets/Query.svg";
                  break;
                case 4:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DepartmentAllocation()));
                  assetLoc = "assets/department-allocation.svg";
                  break;
                case 5:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OnTheJobTraining()));
                  assetLoc = "assets/onthejobbb.svg";
                  break;
                case 6:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OtjtQuery()));
                  assetLoc = "assets/on_the_job_query.svg";
                  break;
                case 7:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => promotionPage()));
                  assetLoc = "assets/promotion.svg";
                  break;
                case 8:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Manning()));
                  assetLoc = "assets/manning.svg";
                  break;
                case 9:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ManningQuery()));
                  assetLoc = "assets/manningQuery.svg";
                  break;
              }
            },
            child: Container(
              height: heightVar,
              width: widthVar,
              child: SvgPicture.asset(assetLoc, width: 5.h, height: 10.h),
              
              // padding: EdgeInsets.symmetric(vertical: 55, horizontal: 5),
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
        child: WillPopScope(
          onWillPop: () => showExitPopup(context),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10.0, 20.0, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
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
                        departmentButton('Add Trainee', 16.0.h, 16.0.h, 1),
                        departmentButton('SDC Training', 16.0.h, 16.0.h, 2),
                        departmentButton('SDC Query', 16.0.h, 16.0.h, 3),
                        departmentButton(
                            'Department \n Allocation', 16.0.h, 16.0.h, 4),
                        departmentButton(
                            'On the Job \n Training', 16.0.h, 16.0.h, 5),
                        departmentButton('Skill Query',
                            16.0.h, 16.0.h, 6),
                        departmentButton('Promotion', 16.0.h, 16.0.h, 7),
                        departmentButton('Manning', 16.0.h, 16.0.h, 8),
                        departmentButton('Manning Query', 16.0.h, 16.0.h, 9),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shadowColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 2,
                            //color: Colors.amber,

                            padding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 11.6.h),
                            onPrimary: Colors.white // foreground
                            ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => deleteTrainee()));
                        },
                        child: Text('Delete Trainee'),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
