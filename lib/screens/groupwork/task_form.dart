import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';


class TaskForm extends StatefulWidget {
  final String assignmentId;
  final String groupId;
  TaskForm({Key key,this.assignmentId,this.groupId}) : super(key: key);
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  ProfileBloc _profileBloc;
  String email;


  final format = DateFormat("yyyy-MM-dd HH:mm");
  final _taskController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _assignedDate = TextEditingController();
  final _dueDate = TextEditingController();
  final  _key = new GlobalKey<FormState>();
  var dropdownValue;
    var priorityDropdown;
  @override
  void initState() {
    super.initState();
    //TODO Finding the best soulution to access other bloc data
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.state.listen((state){
      if(state is ProfileLoaded){
        email = state.data.email;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    final _membersBloc = BlocProvider.of<MembersBloc>(context);
    
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
        bottomLeft: FlatButton(
          onPressed: (){
            _taskController.clear();
            _descriptionController.clear();
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        bottomRight: FlatButton(
          onPressed: (){
            //TODO using bloc or not?
            DateTime assignDate = DateTime.parse(_assignedDate.text);
            DateTime dueDate = DateTime.parse(_dueDate.text);
            _taskBloc.dispatch(AddNewTaskEvent(assignmentId: widget.assignmentId,groupId: widget.groupId,
                  task: TaskModel(task: _taskController.text, description: _descriptionController.text, 
                                  creator: email, createdDate: DateTime.now(), 
                                  assignDate: assignDate, 
                                  dueDate: dueDate, assignTo: dropdownValue, lastUpdated: DateTime.now(), priority: priorityDropdown,status: 0)));
            Navigator.of(context).pop();
          },
          child: Text("Accept"),
        ),
      
      );
    }

    Widget _captions({@required text}){
      return Text(
          "$text",
          style: TextStyle(
            color: Colors.white30
          ),
        );
    }

    _buildPriorityDropdown(){

      //TODO Dumbfuck but working

      var data  = ['highest','high','normal'];
      List<DropdownMenuItem> items = [];
      for(int i = 0 ; i<data.length;i++){
        items.add(DropdownMenuItem<int>(
          value: i,
          child: Text(data[i]),
        ));
      }

      return DropdownButtonFormField(
        items: items,
        value: priorityDropdown,
        onChanged: (value){
          setState(() {
            priorityDropdown = value;
          });
        }
      );
    }

     _buildMembersDropdown() {
      return BlocBuilder<MembersBloc, MembersState>(
        bloc: _membersBloc,
        builder: (context, state) {
          if (state is LoadingMembersState) {
            return DropdownButtonFormField(
              value: "Loading ...",
            );
          }
          if (state is LoadedMembersState) {
            List<DropdownMenuItem> items =
                state.data.map<DropdownMenuItem<String>>((var member) {
              return DropdownMenuItem<String>(
                value: member.email,
                child: Text(member.email),
              );
            }).toList();
            return DropdownButtonFormField(
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value;
                  });
                },
                value: dropdownValue,
                items: items);
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: BlocListener(
        bloc: _taskBloc,
        listener: (context,state){
          if(state is DisplayMessageSnackbar){
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.message}"),
              )
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20) 
          ),
          padding: EdgeInsets.all(16),
          child: Form(
            key: _key,
            child: ListView(
              children: <Widget>[
                _captions(text: "Define your task as simple as possible"),
                TextFormField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    labelText: "Task"
                  ),
                ),
                SizedBox(height: 15,),
                _captions(text: "Ellaborate What the task is"),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Description"
                  ),
                ),
                SizedBox(height: 15,),
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
                SizedBox(height: 15,),
                _buildMembersDropdown(),
                SizedBox(height: 15,),
                _captions(text: "Correspond with the Assignment Due Date"),
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
                SizedBox(height: 15,),
                _captions(text: "Priority"),
                _buildPriorityDropdown(),
              ],
          ),
          )
        ),
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