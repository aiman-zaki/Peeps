import 'package:flutter/material.dart';
import 'package:peeps/models/task.dart';

import 'draggable_task.dart';
import 'draggable_task_zone.dart';
enum TaskStatus{
  todo,
  doing,
  done,
}
typedef AddToChangeStatusList = void Function(String,int); 
class DraggableTaskZone extends StatefulWidget {
  
  final List<DraggableTask> draggable;
  final List<TaskModel> taskList;
  final Color backgroundcolor;
  final String zoneTitle;
  final Function onAccept;

  DraggableTaskZone({Key key,@required this.draggable,@required this.taskList,@required this.backgroundcolor,this.zoneTitle, this.onAccept}) : super(key: key);
  _DraggableTaskZoneState createState() => _DraggableTaskZoneState();
}

class _DraggableTaskZoneState extends State<DraggableTaskZone> {
  @override
  Widget build(BuildContext context) {
    //TODO: Temp will change
    
    int status = 0;
    if(widget.zoneTitle != null){
      if(widget.zoneTitle.toLowerCase() == "todo")
        status = 0;
      if(widget.zoneTitle.toLowerCase() == "doing")
        status = 1;
      if(widget.zoneTitle.toLowerCase() == "done")
        status = 2;
    }

    
    
    AddToChangeStatusList _addToChangeStatusList = widget.onAccept;
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
            _addToChangeStatusList(data.id,status);
            widget.draggable.add(
              DraggableTask(data: data,
                onDragCompleted: (){
                  setState(() {
                    widget.draggable.removeWhere((item) => item.data.id == data.id);
                    
                  });
                },
              )
            );
          });
      },
    );
  }
}