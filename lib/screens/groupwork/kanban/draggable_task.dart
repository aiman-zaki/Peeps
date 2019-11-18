import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/task.dart';

import 'card_task.dart';

class DraggableTask extends StatefulWidget {
  final bool assignmentIsDone;

  final TaskModel data;

  final Function onDragCompleted;
  DraggableTask({Key key, @required this.assignmentIsDone,@required this.data, this.onDragCompleted})
      : super(key: key);
  _DraggableTaskState createState() => _DraggableTaskState();
}

class _DraggableTaskState extends State<DraggableTask> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc,ProfileState>(
      builder: (context,state){
        if(state is ProfileLoaded){
          return Draggable<TaskModel>(
            maxSimultaneousDrags: widget.assignmentIsDone ? 0 : state.data.email == widget.data.assignTo ? 1 : 0,
            data: widget.data,
            onDragCompleted: widget.onDragCompleted,
            child: Container(
              width: 100,
              height: 80,
              child: CardTask(
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
            ));
        }
      },
    );
  }
}
