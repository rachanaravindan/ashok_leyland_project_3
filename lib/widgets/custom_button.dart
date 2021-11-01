import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;

  const CustomButton(
      {this.text, this.onPressed, this.outlineBtn, this.isLoading});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    bool _outlinedBtn = widget.outlineBtn ?? false;
    bool _isLoading = widget.isLoading ?? false;
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          height: 2.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: _outlinedBtn ? Colors.transparent : Colors.amber,
              border: Border.all(
                color: Colors.amber,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0)),
          margin: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 8.0,
          ),
          child: Stack(
            children: [
              Visibility(
                visible: _isLoading ? false : true,
                child: Center(
                  child: Text(
                    widget.text ?? "Text",
                    style: TextStyle(
                        color: _outlinedBtn ? Colors.black : Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Visibility(
                visible: _isLoading,
                child: Center(
                  child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
