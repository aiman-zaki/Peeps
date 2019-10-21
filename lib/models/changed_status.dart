import 'package:flutter/cupertino.dart';

class ChangedStatus{
  final String taskId;
  final String task;
  final String by;
  int previousStatus;
  int status;

  ChangedStatus({
    @required this.taskId,
    @required this.task,
    @required this.by,
    @required this.previousStatus,
    @required this.status,
  });

  Map<String,dynamic> toJson(){
    return {
      'id':taskId,
      'status':status
    };
  }

}
