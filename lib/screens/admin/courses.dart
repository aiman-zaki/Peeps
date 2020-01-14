import 'package:flutter/material.dart';


class CoursesListView extends StatefulWidget {
  CoursesListView({Key key}) : super(key: key);

  @override
  _CoursesListViewState createState() => _CoursesListViewState();
}

class _CoursesListViewState extends State<CoursesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
      ),
      body: Container(
      ),
    );
  }
}