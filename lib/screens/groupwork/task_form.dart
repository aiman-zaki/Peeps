import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
class TaskForm extends StatefulWidget {
  TaskForm({Key key}) : super(key: key);

  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final _taskController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _assignedDate = TextEditingController();
  final _dueDate = TextEditingController();
  final  _key = new GlobalKey<FormState>();


 

  @override
  Widget build(BuildContext context) {
    
    Widget _showConfirmationDialog(){
      return DialogWithAvatar(
        width: 400,
        height: 180,
        avatarIcon: Hero(tag: "confirm",child: Icon(Icons.check),),
        title: "Confirm",
        description: "Process with the task creation?",
        children: <Widget>[
          SizedBox(height: 15,)
        ],
        bottomRight: FlatButton(
          onPressed: (){
            _taskController.clear();
            _descriptionController.clear();
            Navigator.of(context).pop();
        
          
          },
          child: Text("Accept"),
        ),
        bottomLeft: FlatButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
      
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Container(
        padding: EdgeInsets.all(9),
        child: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: "Task"
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Description"
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Description"
                ),
              ),
              DateTimeField(
                decoration: InputDecoration(
                  labelText: "Assign Date"
                ),
                controller: _assignedDate,
                format: format,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
              DateTimeField(
                decoration: InputDecoration(
                  labelText: "Due Date"
                ),
                controller: _dueDate,
                format: format,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
            ],
        ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        heroTag: "confirm",
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return _showConfirmationDialog();
              
            }
          );
        }
      ),
      
    );
  }
}