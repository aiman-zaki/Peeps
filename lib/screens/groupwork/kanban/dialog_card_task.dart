import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/enum/approval_enum.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/resources/task_repository.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/groupwork/kanban/task_review.dart';

import '../task_form.dart';


class DialogTaskCard extends StatefulWidget {
  final String assignmentId;
  final TaskModel task;
  final Color headerColor;
  final isLeader;
  DialogTaskCard({
    Key key,
    @required this.task,
    @required this.headerColor, 
    @required this.isLeader,
    @required this.assignmentId,
    }) : super(key: key);

  @override
  _DialogTaskCardState createState() => _DialogTaskCardState();
}

class _DialogTaskCardState extends State<DialogTaskCard> {
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("AssignmentId: ${widget.assignmentId}");

    final _deleteTextController = TextEditingController();
    final _key = new GlobalKey<FormState>();
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    final _membersBloc = BlocProvider.of<MembersBloc>(context);
    final _timelineBloc = BlocProvider.of<TimelineBloc>(context);
    ProfileLoaded _userProfile = BlocProvider.of<ProfileBloc>(context).state;
  
    _showRequestConfirmationDialog(data){
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context){
          return DialogWithAvatar(
            avatarIcon: Icon(Icons.check),
            title: Text("Request"),
            description: "",
            children: <Widget>[
              TextField(
                controller: _messageController,
              )
            ],
            bottomRight: FlatButton(
              child: Text("Request"),
              onPressed: (){
                _taskBloc.add(
                  RequestChangeAssignTo(
                    data: TaskRequestModel(
                      id: "",
                      from: widget.task.assignTo,
                      taskId: widget.task.id,
                      requester: _userProfile.data.email,
                      approval:Approval.tbd, 
                      message: _messageController.text,
                      createdDate: DateTime.now(),
                      dueDate: DateTime.now(),
                    ),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
            bottomLeft: FlatButton(
              child: Text("Cancel"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          );
          
        }
      );
    }

    Widget _buildBody() {
      return Padding(
        padding: EdgeInsets.all(9),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    'Description : ',
                    style: TextStyle(color: Colors.cyan[300]),
                  ),
                ),
                Flexible(child: Text(widget.task.description)),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Text(
                  'Creator : ',
                  style: TextStyle(color: Colors.cyan[300]),
                ),
                Text(widget.task.creator),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Assign To : ',
                  style: TextStyle(color: Colors.cyan[300]),
                ),
                Text(widget.task.assignTo),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Due Date : ',
                  style: TextStyle(color: Colors.cyan[300]),
                ),
                Text(widget.task.dueDate.toString()),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Text("Request"),
                    onPressed: (){
                      _showRequestConfirmationDialog(widget.task);
                    }, 
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Text("Review"),
                    onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context){
                            return BlocProvider(create: (context) => 
                              TaskItemsReviewsBloc(timelineBloc:_timelineBloc,repository: TaskRepository(data: widget.assignmentId, data2: widget.task.id))..add(ReadItemsReviewsEvent()), 
                                child: TaskReviewView(tasks: widget.task,isLeader:widget.isLeader));
                          }
                        )
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    _showConfirmationDialog(String title) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogWithAvatar(
              width: 400,
              height: 200,
              avatarIcon: Icon(Icons.warning),
              title: Text('Delete $title?'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _key,
                    child: TextFormField(
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Please Enter Task Title';
                        }
                        if (_deleteTextController.text != title) {
                          return 'Not Same';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Task Title',
                      ),
                      controller: _deleteTextController,
                    ),
                  ),
                )
              ],
              bottomLeft: FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              bottomRight: FlatButton(
                child: Text('Delete'),
                onPressed: () {
                  if (_key.currentState.validate()) {
                    _taskBloc
                        .add(DeleteTaskButtonClickedEvent(taskId: widget.task.id));
                  }
                },
              ),
            );
          });
    }

    Widget _buildHeader() {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            color: widget.headerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _showConfirmationDialog(widget.task.task);
                },
                child: Icon(Icons.delete)),
            ),
            Flexible(flex:2,child: Text(widget.task.task)),
            Expanded(
              flex: 1,
              child: InkWell(
                  child: Icon(Icons.edit),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                          value: _taskBloc,
                          child: BlocProvider.value(
                              value: _membersBloc,
                              child: BlocProvider.value(
                                  value: _timelineBloc,
                                  child: TaskForm(
                                    task: widget.task,
                                    edit: true,
                                  )))),
                      fullscreenDialog: true,
                    ));
                  },
                ),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Container(
        height: 315,
        child: Dialog(
          elevation: 1.00,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            padding: EdgeInsets.only(bottom: 9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildHeader(),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
