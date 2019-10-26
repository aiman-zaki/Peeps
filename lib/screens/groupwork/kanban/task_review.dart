import 'package:flutter/material.dart';


class TaskReviewView extends StatefulWidget {
  TaskReviewView({Key key}) : super(key: key);

  _TaskReviewViewState createState() => _TaskReviewViewState();
}

class _TaskReviewViewState extends State<TaskReviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Review"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
        },
        child: Icon(Icons.add),
      ),
    );
  }
}