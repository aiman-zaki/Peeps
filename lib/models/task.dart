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
  });
  static TaskModel fromJson(Map<String,dynamic> json){
    return TaskModel(
      id: json['_id']['\$oid'],
      creator: json['creator'],
      assignTo: json['assignTo'],
      task: json['task'],
      description: json['description'],
      assignDate: DateTime.parse(json['assignDate']),
      createdDate: DateTime.parse(json['createdDate']),
      dueDate: DateTime.parse(json['dueDate']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
      status: json['status'],
      priority: (json['priority']),
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "creator":this.creator,
      "assignTo":this.assignTo,
      "task":this.task,
      "description":this.description,
      "createdDate":this.createdDate.toString(),
      "assignDate":this.assignDate.toString(),
      "dueDate":this.dueDate.toString(),
      "lastUpdated":this.lastUpdated.toString(),
      "priority": 3,
    };
  }
}