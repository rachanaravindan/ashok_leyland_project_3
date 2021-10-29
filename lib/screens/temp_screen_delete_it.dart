// // this page is for temporary use

// import 'package:flutter/material.dart';

// class ToggleButton extends StatefulWidget {
//   @override
//   _ToggleButtonState createState() => _ToggleButtonState();
// }

// class _ToggleButtonState extends State<ToggleButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             ToggleButtons(
//               isSelected: isSelected2,
//               borderColor: Colors.amber,
//               selectedBorderColor: Colors.red,
//               fillColor: Colors.blue,
//               selectedColor: Colors.amber,
//               highlightColor: Colors.pink,
//               children: <Widget>[
//                 Icon(Icons.ac_unit),
//                 Icon(Icons.call),
//                 Icon(Icons.cake),
//               ],
//               onPressed: (int index) {
//                 setState(() {
//                   if (isSelected2[index] == true) {
//                     isSelected2[index] = false;
//                   } else {
//                     isSelected2[index] = true;
//                   }
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
