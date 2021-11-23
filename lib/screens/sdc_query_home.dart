import 'dart:ui' as ui;
import 'package:ashok_leyland_project_3/screens/sdc_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:sizer/sizer.dart';

class SdcQueryHome extends StatefulWidget {
  @override
  _SdcQueryHomeState createState() => _SdcQueryHomeState();
}

class _SdcQueryHomeState extends State<SdcQueryHome> {
  final double _borderRadius = 24;

  var items = [
    QueryCard('Query By Level', Color(0xff6DC8F3), Color(0xff73A1F9), true),
    QueryCard('Query By Program', Color(0xffFF5B95), Color(0xffF8556D), true),
  ];

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          body: ListView.builder(
            padding: EdgeInsets.only(top: 30.h),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Bounce(
                duration: Duration(milliseconds: 110),
                onPressed: () {
                  print(items[index].isLevelQuery);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SdcQuery(
                              isLevelQuery: items[index].isLevelQuery)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(_borderRadius),
                          gradient: LinearGradient(
                              colors: [
                                items[index].startColor,
                                items[index].endColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          boxShadow: [
                            BoxShadow(
                              color: items[index].endColor,
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: CustomPaint(
                          size: Size(100, 150),
                          painter: CustomCardShapePainter(_borderRadius,
                              items[index].startColor, items[index].endColor),
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            items[index].name,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class QueryCard {
  final String name;
  final bool isLevelQuery;
  final Color startColor;
  final Color endColor;

  QueryCard(this.name, this.startColor, this.endColor, this.isLevelQuery);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
