import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/enum/approval_enum.dart';
import 'package:peeps/enum/status_enum.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/members.dart';
import 'package:peeps/models/timeline.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
//TODO : Dynamic Role Assignation - Madam Faridah

class AssignmentFormView extends StatefulWidget {
  final bool isEdit;
  final String groupId;
  final userData;
  final AssignmentModel assignmentData;

  const AssignmentFormView({
    Key key, 
    @required this.groupId,
    @required this.userData,
    @required this.isEdit,
    this.assignmentData,
    }) : super(key: key);

  _AssignmentFormState createState() => new _AssignmentFormState();
}

class _AssignmentFormState extends State<AssignmentFormView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDate = TextEditingController();
  final _totalMarks = TextEditingController();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  var _leader;

  @override
  void initState() {
    super.initState();
    if(widget.isEdit){
      _titleController.text = widget.assignmentData.title;
      _descriptionController.text = widget.assignmentData.description;
      _dueDate.text = widget.assignmentData.dueDate.toString();
      _leader = widget.assignmentData.leader;
      _totalMarks.text = widget.assignmentData.totalMarks.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _assignmentBloc = BlocProvider.of<AssignmentBloc>(context);
    final _membersBloc = BlocProvider.of<MembersBloc>(context);
    Widget _captions({@required text}) {
      return Text(
        "$text",
        style: TextStyle(color: Colors.white30),
      );
    }
    _buildDialog() {
      showDialog(
          context: (context),
          builder: (context) {
            return DialogWithAvatar(
              avatarIcon: Icon(Icons.check),
              title: "Confirm",
              description: " ${widget.isEdit? 'Update': 'New'} Assignment?",
              width: 400,
              height: 180,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
              ],
              bottomLeft: FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              bottomRight: FlatButton(
                child: Text('Confirm'),
                onPressed: () {
                  if(widget.isEdit){
                    _assignmentBloc.add(UpdateAssignmentEvent(
                      data: AssignmentModel(
                          id: widget.assignmentData.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          leader: _leader,
                          totalMarks: double.parse(_totalMarks.text),
                          createdDate: widget.assignmentData.createdDate,
                          dueDate: DateTime.parse(_dueDate.text),
                          status: widget.assignmentData.status,
                          approval: widget.assignmentData.approval,
                          startDate: widget.assignmentData.startDate,
                          ),
                    ));
                  } else {
                    _assignmentBloc.add(AddAssignmentEvent(
                      assignment: AssignmentModel(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          leader: _leader,
                          totalMarks: double.parse(_totalMarks.text),
                          createdDate: DateTime.now(),
                          dueDate: DateTime.parse(_dueDate.text),
                          status: Status.ongoing,
                          approval: Approval.tbd,
                          startDate: DateTime.now(),
                          ),
                   ));
                  }
                  
                  Navigator.of(context).pop();
                },
              ),
            );
          });
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
                    _leader = value;
                  });
                },
                value: _leader,
                items: items);
          }
        },
      );
    }

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Assignment Form'),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _captions(text: "Make it short"),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: "Title"),
                  ),
                  SizedBox(height: 15,),
                  _captions(text: "Summary of the Assignment"),
                  TextFormField(
                    minLines: 1,
                    maxLines: 2,
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: "Description"),
                  ),
                  SizedBox(height: 15,),
                  _captions(text: "Choose the leader responsible for the Assignment \nDropdown or Dynamic[soon]"),
                  _buildMembersDropdown(),
                  SizedBox(height: 15,),
                  _captions(text: "Total carry mark"),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _totalMarks,
                    decoration: InputDecoration(labelText: "Total Marks"),
                  ),
                  SizedBox(height: 15,),
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
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            _buildDialog();
          },
        ));
  }
}
