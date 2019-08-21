import 'package:flutter/material.dart';
import 'package:peeps/models/task.dart';

import 'draggable_task.dart';
import 'draggable_task_zone.dart';

//TODO Notifiation when updated Kanban


class Board extends StatefulWidget {

    final List<TaskModel> todo;
    final List<TaskModel> doing;
    final List<TaskModel> done;
 

  Board({
    Key key,
    @required this.todo,
    @required this.doing,
    @required this.done,
    }) : super(key: key);

  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<DraggableTask> draggableTodo = [];
  List<DraggableTask> draggableDoing = [];
  List<DraggableTask> draggableDone = [];
  List<Draggable> test = [];

  //TODO : Working but dumb
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
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: DraggableTaskZone(
              draggable: draggableTodo,
              taskList: widget.todo,
              zoneTitle: "Todo",
              
            )
          ),
          Expanded(
            child: DraggableTaskZone(
              draggable: draggableDoing,
              taskList: widget.doing,
              zoneTitle: "Doing",
            ),
          ),
          Expanded(
            child: DraggableTaskZone(
              draggable: draggableDone,
              taskList: widget.done,
              zoneTitle: "Done",
            ),
          ),
        ],
      ),
    );
    
  }
  @override
  void initState() {
    _buildDraggable();
    super.initState();
  }

}