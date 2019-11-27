import 'package:flutter/material.dart';
import 'package:peeps/models/template.dart';

class TasksTemplateFormView extends StatefulWidget {
  TasksTemplateFormView({Key key}) : super(key: key);

  @override
  _TasksTemplateFormViewState createState() => _TasksTemplateFormViewState();
}

class _TasksTemplateFormViewState extends State<TasksTemplateFormView> {
  final List<TaskTemplateModel> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop(tasks);
          },
        ),
        title: Text("Tasks Template Form"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(child: Text("ADD"),onPressed: (){
              setState(() {
                tasks.add(TaskTemplateModel(
                title: "halo mama",
                description: "halo halo",
                difficulty: 10
              ));
              });
            },)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pop(tasks);
        },
      ),
    );
  }
}