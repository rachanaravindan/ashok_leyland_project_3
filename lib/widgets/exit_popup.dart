import 'dart:io';
import 'package:flutter/material.dart';

Future<bool> showExitPopup(context) async{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 92,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to exit?"),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // print('yes selected');
                          exit(0);
                        },
                        child: Text("Yes", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff016FB6)),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        // print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text("No", style: TextStyle(color: Color(0xff016FB6))),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
} 