import 'package:flutter/material.dart';
import 'package:peeps/enum/task_status_enum.dart';
import 'package:peeps/models/task.dart';

import 'draggable_task.dart';
import 'draggable_task_zone.dart';

typedef AddToChangeStatusList = void Function({String taskId,int newStatus,String task,int prevStatus}); 
class DraggableTaskZone extends StatefulWidget {
  final String assignmentId;
  final isLeader;
  final List<DraggableTask> draggable;
  final List<TaskModel> taskList;
  final Color backgroundcolor;
  final TaskStatus zone;
  final Function onAccept;

  DraggableTaskZone({Key key,@required this.assignmentId,@required this.draggable,@required this.taskList,@required this.backgroundcolor,this.zone, this.onAccept, @required this.isLeader}) : super(key: key);
  _DraggableTaskZoneState createState() => _DraggableTaskZoneState();
}

class _DraggableTaskZoneState extends State<DraggableTaskZone> {
  @override
  Widget build(BuildContext context) {
    AddToChangeStatusList _addToChangeStatusList = widget.onAccept;
    return DragTarget(
      builder: (BuildContext context, List candidateData, List rejectedData) {
          return Container(
            color: (widget.backgroundcolor),
            child: Scrollbar(
              child: ListView(
                children: [
                  widget.zone != null ?
                  Container(
                    alignment: Alignment(0.0,0.0),
                    margin: EdgeInsets.only(top: 10),
                    child: Text(getTaskStatusStringEnum(widget.zone),
                      style: TextStyle(
                        fontSize: 22,
                      ),),
                  ) : Container(),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: widget.draggable,
                  )
                ],
              ),
            ),
          );
      },
      onWillAccept: (TaskModel data){
        bool accept;
        widget.draggable.where((item) => item.data.id == data.id).length >= 1 ? accept = false : accept = true;
          return accept;
      },
        onAccept: (TaskModel data){
          setState(() {
            _addToChangeStatusList(taskId:data.id,newStatus:widget.zone.index,task:data.task,prevStatus:data.status.index);
            widget.draggable.add(
              DraggableTask(
                data: data,
                assignmentId: widget.assignmentId,
                isLeader: widget.isLeader,
                onDragCompleted: (){
                  setState(() {
                    widget.draggable.removeWhere((item) => item.data.id == data.id);
                    
                  });
                }, isDone: false,
              )
            );
          });
      },
    );
  }
}