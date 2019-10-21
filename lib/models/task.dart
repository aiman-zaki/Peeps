import 'package:flutter/widgets.dart';

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
  int status;
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
      status: json['status'],
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
      "status":this.status,
      "seq":this.seq,
    };
  }
}