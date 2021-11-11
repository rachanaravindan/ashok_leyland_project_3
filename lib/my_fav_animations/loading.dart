import 'package:ashok_leyland_project_3/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[200],
      child: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFoldingCube(
              color: Colors.blueAccent,
              size: 50.0,
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Loading",style:Constants.boldHeading),
            )
          ],
        ),
      ),
    );
  }
}
