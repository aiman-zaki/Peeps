import 'package:flutter/material.dart';


class AssignmentScoreView extends StatefulWidget {
  AssignmentScoreView({Key key}) : super(key: key);

  @override
  _AssignmentScoreViewState createState() => _AssignmentScoreViewState();
}

class _AssignmentScoreViewState extends State<AssignmentScoreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            
          ],
        ),
      ),
    );
  }
}