import 'package:flutter/widgets.dart';
import 'package:peeps/enum/approval_enum.dart';
import 'package:peeps/enum/task_status_enum.dart';

class TaskModel{
  String id;
  String creator;
  String assignTo;
  String task;
  String description;
  DateTime createdDate;
  DateTime assignDate;
  DateTime dueDate;
  DateTime lastUpdated;
  TaskStatus status;
  int priority;
  int seq;
  TaskModel({
    this.id,
    @required this.creator,
    @required this.assignTo,
    @required this.task,
    @required this.description,
    @required this.createdDate,
    @required this.assignDate,
    @required this.dueDate,
    @required this.lastUpdated,
    @required this.status,
    this.priority,
    this.seq,
  });
  static TaskModel fromJson(Map<String,dynamic> json){
    return TaskModel(
      id: json['_id']['\$oid'],
      creator: json['creator'],
      assignTo: json['assign_to'],
      task: json['task'],
      description: json['description'],
      assignDate: DateTime.parse(json['assign_date']),
      createdDate: DateTime.parse(json['created_date']),
      dueDate: DateTime.parse(json['due_date']),
      lastUpdated: DateTime.parse(json['last_updated']),
      status: TaskStatus.values.elementAt(json['status']),
      priority: json['priority'],
      seq: json['seq'],
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "creator":this.creator,
      "assign_to":this.assignTo,
      "task":this.task,
      "description":this.description,
      "created_date":this.createdDate.toString(),
      "assign_date":this.assignDate.toString(),
      "due_date":this.dueDate.toString(),
      "last_updated":this.lastUpdated.toString(),
      "priority": this.priority,
      "status":this.status.index,
      "seq":this.seq,
    };
  }
}


class TaskRequestModel{
  final String id;
  final String taskId;
  final String requester;
  final String from;
  final TaskModel task;
  final String message;
  DateTime createdDate;
  Approval approval;

  TaskRequestModel({
    @required this.id,
    @required this.taskId,
    @required this.requester,
    this.from,
    @required this.approval,
    @required this.message,
    @required this.createdDate,
    this.task,
  });

  static TaskRequestModel fromJson(Map<String,dynamic> json){
    return TaskRequestModel(
      id: json['_id']['\$oid'],
      taskId: json['task_id']['\$oid'],
      requester: json['requester'],
      approval: Approval.values.elementAt(json['approval']),
      message: json['message'],
      createdDate: DateTime.parse(json['created_date']),
      task: TaskModel.fromJson(json['task'])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "task_id":this.taskId,
      "requester":this.requester,
      "approval":this.approval.index,
      "message":this.message,
      "created_date":this.createdDate.toString(),
    };
  }


}