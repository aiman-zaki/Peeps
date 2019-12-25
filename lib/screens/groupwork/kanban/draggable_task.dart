import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/task.dart';

import 'card_task.dart';

class DraggableTask extends StatefulWidget {
  DraggableTask({Key key, @required this.isDone,@required this.data, this.onDragCompleted, @required this.isLeader,@required this.assignmentId})
      : super(key: key);

  final assignmentId;
  final TaskModel data;
  final bool isDone;
  final bool isLeader;
  final Function onDragCompleted;

  _DraggableTaskState createState() => _DraggableTaskState();
}

class _DraggableTaskState extends State<DraggableTask> {
  bool _draggable = false;

  @override
  void initState() {
    super.initState();
    String email = (BlocProvider.of<ProfileBloc>(context).state as ProfileLoaded).data.email;
    if(!widget.isDone){
      if(email == widget.data.assignTo || widget.isLeader){
        _draggable = true;
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<TaskModel>(
        maxSimultaneousDrags: _draggable ? 1 : 0,
        data: widget.data,
        onDragCompleted: widget.onDragCompleted,
        child: Container(
          width: 100,
          height: 80,
          child: CardTask(
            assignmentId: widget.assignmentId,
            isLeader: widget.isLeader,
            task: widget.data,
          ),
        ),
        feedback: Card(
          child: Container(
            width: 100,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[Text(widget.data.task)],
            ),
          ),
        )
      );
    }
}
