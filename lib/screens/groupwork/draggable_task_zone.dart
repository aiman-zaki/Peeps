import 'package:flutter/material.dart';
import 'package:peeps/models/task.dart';

import 'draggable_task.dart';
import 'draggable_task_zone.dart';


class DraggableTaskZone extends StatefulWidget {
  
  final List<DraggableTask> draggable;
  final List<TaskModel> taskList;
  final Color backgroundcolor;
  final String zoneTitle;

  DraggableTaskZone({Key key,@required this.draggable,@required this.taskList,@required this.backgroundcolor,this.zoneTitle}) : super(key: key);
  _DraggableTaskZoneState createState() => _DraggableTaskZoneState();
}

class _DraggableTaskZoneState extends State<DraggableTaskZone> {
  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (BuildContext context, List candidateData, List rejectedData) {
          return Container(
            color: (widget.backgroundcolor),
            child: Scrollbar(
              child: ListView(
                children: [
                  widget.zoneTitle != null ?
                  Container(
                    alignment: Alignment(0.0,0.0),
                    margin: EdgeInsets.only(top: 10),
                    child: Text(widget.zoneTitle,
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
       //TODO WORKING BUT SMALL BRAIN
        widget.draggable.where((item) => item.data.id == data.id).length >= 1 ? accept = false : accept = true;
          return accept;
      },
        onAccept: (TaskModel data){
          setState(() {
            widget.taskList.add(data);
            widget.draggable.add(
              DraggableTask(data: data,
                onDragCompleted: (){
                  setState(() {
                    widget.draggable.removeWhere((item) => item.data.id == data.id);
                    widget.taskList.removeWhere((item) => item.id == data.id);
                  });
                },
              )
            );
          });
      },
    );
  }
}