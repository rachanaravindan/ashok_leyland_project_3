import 'package:ashok_leyland_project_3/constants.dart';
import 'package:flutter/material.dart';

class customInput extends StatelessWidget {
  final String HintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPassword;

  const customInput(
      {this.HintText,
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
        horizontal: 24.0,
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
            hintText: HintText ?? "Hint text",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 18.0,
            )),
        style: constants.regularDarkText,
      ),
    );
  }
}
