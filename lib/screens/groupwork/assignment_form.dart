import 'package:flutter/material.dart';

//TODO : Dynamic Role Assignation - Madam Faridah



class AssignmentForm extends StatelessWidget {
  const AssignmentForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Assignment Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(decoration: InputDecoration(labelText:  "Title"),),
              TextFormField(decoration: InputDecoration(labelText:  "Description"),),
              TextFormField(decoration: InputDecoration(labelText:  "Leader"),),
              TextFormField(decoration: InputDecoration(labelText:  "Total Marks"),),
            ],
          ),
        ),
      ),
    );
  }
}