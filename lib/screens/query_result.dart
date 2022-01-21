import 'package:altraport/models/card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';

class QueryResultScreen extends StatefulWidget {
  final List searchResults;

  const QueryResultScreen({Key key, this.searchResults}) : super(key: key);
  @override
  _QueryResultScreenState createState() => _QueryResultScreenState();
}

class _QueryResultScreenState extends State<QueryResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.searchResults.length > 0
          ? ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            itemCount: widget.searchResults.length,
            itemBuilder: (BuildContext context, int index) =>
                buildCard(context, widget.searchResults[index], 1),
          )
          : Padding(
              padding: EdgeInsets.only(top: 5.w),
              child: Text("No Results", style: Constants.regularHeading),
            ),
    );
  }
}
