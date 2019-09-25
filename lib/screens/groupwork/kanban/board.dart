import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/changed_status.dart';
import 'package:peeps/models/task.dart';

import 'draggable_task.dart';
import 'draggable_task_zone.dart';

//TODO Notifiation when updated Kanban


class Board extends StatefulWidget {
  final List<TaskModel> todo;
  final List<TaskModel> doing;
  final List<TaskModel> done;

  final Function(List<ChangedStatus>) callback;
  final String  assignmentId;
  Board({
    Key key,
    @required this.todo,
    @required this.doing,
    @required this.done,
    this.callback,
    this.assignmentId,
    
    }) : super(key: key);

  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  
  final List<ChangedStatus> changedStatus = [];
  final List<DraggableTask> draggableTodo = [];
  final List<DraggableTask> draggableDoing = [];
  final List<DraggableTask> draggableDone = [];

  @override
  void initState() {
    _buildDraggable();
    super.initState();
  }

  _addToChangedStatusList(String taskId,int status){
      int index = changedStatus.indexWhere((item) => item.taskId == taskId);
      if(index == -1){
        changedStatus.add(ChangedStatus(status: status,taskId: taskId));
      }else{
        changedStatus[index].status = status;
      }
      widget.callback(changedStatus);
    }

  _buildDraggable(){
      for(TaskModel data in widget.todo){
        draggableTodo.add(
          DraggableTask(
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
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: DraggableTaskZone(
              draggable: draggableTodo,
              taskList: widget.todo,
              zoneTitle: "Todo",
              onAccept: _addToChangedStatusList,
              
            )
          ),
          Expanded(
            child: DraggableTaskZone(
              draggable: draggableDoing,
              taskList: widget.doing,
              zoneTitle: "Doing",
              onAccept: _addToChangedStatusList,
            ),
          ),
          Expanded(
            child: DraggableTaskZone(
              draggable: draggableDone,
              taskList: widget.done,
              zoneTitle: "Done",
              onAccept: _addToChangedStatusList,            
            ),
          ),
        ],
      ),
    );
  }

}