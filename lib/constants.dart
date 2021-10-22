import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Constants {
  static const regularHeading =
      TextStyle(
        fontSize: 18.0,
       fontWeight: FontWeight.w600,
       color: Colors.black);
  
  static const boldHeading=TextStyle(
       fontSize:30.0,
       fontWeight: FontWeight.w700,
       color: Colors.black);
  static const regularDarkText=TextStyle(
       fontSize: 16.0,
       fontWeight: FontWeight.w600,
       color: Colors.black);
  static const List<String> choices = <String>[
    "English",
    "Hindi",
    "Tamil"
  ];
}
