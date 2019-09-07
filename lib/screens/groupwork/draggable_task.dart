import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/task_bloc.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/screens/groupwork/card_task.dart';

class DraggableTask extends StatefulWidget {
  final TaskModel data;
  final int mode;
  //List not updated if passtrough
  final Function onDragCompleted;
  DraggableTask({Key key,@required this.data,this.onDragCompleted,this.mode}) : super(key: key);
  _DraggableTaskState createState() => _DraggableTaskState();
}

class _DraggableTaskState extends State<DraggableTask> {
  @override
  Widget build(BuildContext context) {
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    return Draggable<TaskModel>(
          maxSimultaneousDrags: widget.mode == null ? 1 : widget.mode ,
          data: widget.data,
          onDragCompleted: widget.onDragCompleted,
          child: Container(
            width: 100,
            height: 80,
            child: CardTask(task: widget.data,),
          ), feedback: BlocProvider.value(
            value: _taskBloc,
            child: CardTask(task: widget.data,),
          ),
     
      );
  }
}