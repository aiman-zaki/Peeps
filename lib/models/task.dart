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
    this.priority,
  });
  static TaskModel fromJson(Map<String,dynamic> json){
    return TaskModel(
      creator: json['creator'],
      assignTo: json['assignTo'],
      task: json['task'],
      description: json['description'],
      assignDate: json['assignDate'],
      createdDate: json['createdDate'],
      dueDate: json['dueDate'],
      priority: (json['priority']),
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "id":this.id,
      "creator":this.creator,
      "assignTo":this.assignTo,
      "task":this.task,
      "description":this.description,
      "createdData":this.createdDate,
      "assignDate":this.assignDate,
      "dueDate":this.dueDate,
      "priority":this.priority,
    };
  }
}