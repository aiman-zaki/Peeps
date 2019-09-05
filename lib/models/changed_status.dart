import 'package:flutter/cupertino.dart';

class ChangedStatus{
  final String taskId;
  int status;

  ChangedStatus({
    @required this.taskId,
    @required this.status,
  });

  Map<String,dynamic> toJson(){
    return {
      'id':taskId,
      'status':status
    };
  }

}
