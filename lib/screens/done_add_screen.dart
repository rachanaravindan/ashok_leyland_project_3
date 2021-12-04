import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'add_trainee.dart';
import 'home.dart';

class DoneMark extends StatefulWidget {
  final bool screen;

  const DoneMark({Key key, this.screen}) : super(key: key);
  @override
  State<DoneMark> createState() => _DoneMarkState();
}

class _DoneMarkState extends State<DoneMark> with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: Lottie.asset('assets/done.json', controller: _controller,
                    onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..repeat();
            })),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,

                    padding: EdgeInsets.symmetric(
                        vertical: 1.5.h, horizontal: 11.6.h),
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    if (widget.screen) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTrainee()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  },
                  child: Text('Done')),
            ),
          ],
        ),
      ));
    });
  }
}
