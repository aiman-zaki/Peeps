import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/supervisor/bloc.dart';
import 'package:peeps/models/template.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/supervisor/tasks_template.dart';
class GroupworkTemplateFormView extends StatefulWidget {
  final bool isEdit;
  final GroupworkTemplateModel data;
  GroupworkTemplateFormView({Key key,@required this.isEdit,this.data}) : super(key: key);

  @override
  _GroupworkTemplateFormViewState createState() => _GroupworkTemplateFormViewState();
}

class _GroupworkTemplateFormViewState extends State<GroupworkTemplateFormView> {
  final _descriptionController = TextEditingController();
  final _revisionController = TextEditingController();
  final _assignmentTitleController = TextEditingController();
  final _assignmentDescriptionController = TextEditingController();
  final _assignmentDueDateController = TextEditingController();
  final _assignmentTotalMarkController=  TextEditingController();
  final _assignmentStartDateController = TextEditingController();
  List<AssignmentTemplateModel> assignments = [];
  final format = DateFormat("yyyy-MM-dd HH:mm");
  
  @override
  @override
  void initState() { 
    super.initState();
    if(widget.isEdit){
      _descriptionController.text = widget.data.description;
      _revisionController.text = widget.data.revision.toString();
      assignments = widget.data.assignments;
    }
  
  
  }

  _showAddAssignmentDialog(context){
     showDialog(
      context: (context),
      builder: (context){
        return DialogWithAvatar(
          height: 450,
          avatarIcon: Icon(Icons.question_answer),
          description: "",
          title: Text("Assignment Title"),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Assignment Title"
              ),
              controller: _assignmentTitleController,),
         
            TextFormField(
              controller: _assignmentDescriptionController,
              decoration: InputDecoration(
                labelText: "Assignment Description"
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Assignment Total Mark"
              ),
              controller: _assignmentTotalMarkController,),
              DateTimeField(
                    decoration: InputDecoration(
                      labelText: "Start Date"
                    ),
                    controller: _assignmentStartDateController,
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
                    controller: _assignmentDueDateController,
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
          bottomRight: FlatButton(
            onPressed: (){
              setState(() {
                assignments.add(AssignmentTemplateModel(
                  id: "",
                  title: _assignmentTitleController.text,
                  description: _assignmentDescriptionController.text,
                  totalMarks: double.parse(_assignmentTotalMarkController.text),
                  dueDate: DateTime.parse(_assignmentDueDateController.text),
                  startDate: DateTime.parse(_assignmentStartDateController.text),
                  tasks: [],
                ));
                Navigator.of(context).pop();
              });
            },
          child: Text("Confirm"),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
  final _bloc = BlocProvider.of<GroupworkTemplateSupervisorBloc>(context);
    return BlocListener(
      bloc: _bloc,
      listener: (context,state){
        if(state is GroupworkTemplateSupervisorSucessState){
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Template Form"),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.isEdit ? 
                  TextFormField(
                    controller: _revisionController,
                    decoration: InputDecoration(
                      labelText: "Revision"
                    ),
                  ) :
                SizedBox(),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Groupwork Description"
                  ),
                ),
                Divider(height: 10,),
                Row(children: <Widget>[
                  Expanded(flex:3,child: Text("Assignments",style: TextStyle(fontSize: 16),)),
                  Expanded(
                    child: FlatButton(
                      child: Icon(Icons.add),
                      onPressed: (){
                        _showAddAssignmentDialog(context);
                      },
                    ),
                  ),
                ],),
                
             
                Expanded(
                  child: ListView.builder(
                    itemCount: assignments.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: () async {
                          assignments[index].tasks = await Navigator.of(context).push(
                            CupertinoPageRoute(builder: (context) => TasksTemplateFormView(isEdit: widget.isEdit,tasks:assignments[index].tasks))
                          );                 
                        },
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(child: Text("${assignments[index].title}",style: TextStyle(fontSize:18,color: Colors.blue,))),
                                    Expanded(child: Text(assignments[index].startDate.toString()),)
                                  ],
                                  
                                ),
                                SizedBox(height: 10,),
                                Text("Description: ${assignments[index].description}",style: TextStyle(fontSize: 16),),
                                SizedBox(height: 5,),
                                Container(
                                  height: 100,
                                  child: ListView.builder(
                                    itemCount: assignments[index].tasks.length,
                                    itemBuilder: (context,index2){
                                      print(assignments[index].tasks[index2].title);
                                      return ListTile(
                                        title: Text(assignments[index].tasks[index2].title),
                                      );
                                    },
                                  ),
                                )
                            ],),
                          ),
                        ),
                        );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(!widget.isEdit){
              _bloc.add(CreateGroupworkTemplateSupervisorEvent(
                  data: GroupworkTemplateModel(
                    id: "",
                    description: _descriptionController.text,
                    assignments: assignments,
                    revision: 1.00

                )));
            }
            else{
              widget.data.revision = double.parse(_revisionController.text);
              _bloc.add(UpdateGroupworkTemplateSupervisorEvent(data: widget.data));
            }
          },
          child: Icon(Icons.check
        ),
      )),
    );
  }
}