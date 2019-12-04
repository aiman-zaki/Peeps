import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/groupwork/timeline/timeline_bloc.dart';
import 'package:peeps/bloc/user/profile/profile_bloc.dart';
import 'package:peeps/bloc/user/profile/profile_state.dart';
import 'package:peeps/enum/status_enum.dart';
import 'package:peeps/enum/task_status_enum.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/changed_status.dart';
import 'package:peeps/models/task.dart';

import 'draggable_task.dart';
import 'draggable_task_zone.dart';

class Board extends StatefulWidget {
  final List<TaskModel> todo;
  final List<TaskModel> doing;
  final List<TaskModel> done;
  final Function(List<ChangedStatus>) callback;
  final AssignmentModel  assignment;

  Board({
    Key key,
    @required this.todo,
    @required this.doing,
    @required this.done,
    this.callback,
    this.assignment,
    
    }) : super(key: key);

  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  bool isLeader = false;
  final List<ChangedStatus> changedStatus = [];
  final List<DraggableTask> draggableTodo = [];
  final List<DraggableTask> draggableDoing = [];
  final List<DraggableTask> draggableDone = [];
  String email;
  @override
  void initState() {
    email = (BlocProvider.of<ProfileBloc>(context).state as ProfileLoaded).data.email;
    if(widget.assignment.leader == email)
      isLeader = true;
    _buildDraggable();
    super.initState();
  }

  _addToChangedStatusList({String taskId,int newStatus,String task,int prevStatus}){
      int index = changedStatus.indexWhere((item) => item.taskId == taskId);
      if(index == -1){
        changedStatus.add(ChangedStatus(status: newStatus,taskId: taskId, by: email, previousStatus: prevStatus, task: task));
      }else{
        changedStatus[index].status = newStatus;
      }
      widget.callback(changedStatus);
    }

  _buildDraggable(){
      for(TaskModel data in widget.todo){
        draggableTodo.add(
          DraggableTask(
            assignmentId: widget.assignment.id,
            isLeader: isLeader,
            isDone: widget.assignment.status == Status.done ? true : false,
            data: data,
            onDragCompleted: (){
              setState(() {
                draggableTodo.removeWhere((item) => item.data.id == data.id);
              });
            },
            )
        );
      }
      for(TaskModel data in widget.doing){
        draggableDoing.add(
          DraggableTask(
            assignmentId: widget.assignment.id,
            isLeader: isLeader,
            isDone: widget.assignment.status == Status.done ? true : false,
            data: data,
          onDragCompleted: (){
            setState(() {
              draggableDoing.removeWhere((item) => item.data.id == data.id);
            });
          },
          )
        );
      }
      for(TaskModel data in widget.done){
        draggableDone.add(
          DraggableTask(
            assignmentId: widget.assignment.id,
            isLeader: isLeader,
            isDone: widget.assignment.status == Status.done ? true : false,
            data: data,
          onDragCompleted: (){
            setState(() {
              draggableDone.removeWhere((item) => item.data.id == data.id);
            });
          },
          )
        );
      }
    }
  
  @override
  Widget build(BuildContext context) {
  final _timelineBloc = BlocProvider.of<TimelineBloc>(context);

    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: DraggableTaskZone(
              assignmentId: widget.assignment.id,
              isLeader: isLeader,
              draggable: draggableTodo,
              taskList: widget.todo,
              zone: TaskStatus.todo,
              onAccept: _addToChangedStatusList, backgroundcolor: Theme.of(context).backgroundColor,
              
            )
          ),
          Expanded(
            child: DraggableTaskZone(
              assignmentId: widget.assignment.id,
              isLeader: isLeader,
              draggable: draggableDoing,
              taskList: widget.doing,
              zone: TaskStatus.doing,
              onAccept: _addToChangedStatusList,
              backgroundcolor: Theme.of(context).backgroundColor
            ),
          ),
          Expanded(
            child: DraggableTaskZone(
              assignmentId: widget.assignment.id,
              isLeader: isLeader,
              draggable: draggableDone,
              taskList: widget.done,
              zone: TaskStatus.done,
              onAccept: _addToChangedStatusList,   
              backgroundcolor: Theme.of(context).backgroundColor         
            ),
          ),
        ],
      ),
    );
  }

}