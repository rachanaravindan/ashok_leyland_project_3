import 'package:altraport/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPassword;

  const CustomInput(
      {this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPassword});

  @override
  Widget build(BuildContext context) {
    bool _isPassword=isPassword ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 5.0,
      ),
      decoration: BoxDecoration(
          color: Color(0xFFf2F2F2), borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        autofillHints: [AutofillHints.username],
        focusNode: focusNode,
        obscureText: _isPassword,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "Hint text",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 18.0,
            )),
        style: Constants.regularDarkText,
      ),
    );
  }
}
