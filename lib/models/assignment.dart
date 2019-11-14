import 'package:flutter/cupertino.dart';
import 'package:peeps/enum/status_enum.dart';
import 'package:peeps/models/task.dart';

class AssignmentModel{
  String id;
  String title;
  String description;
  String leader;
  Status status;
  double totalMarks;
  double scoredMark;
  DateTime createdDate;
  DateTime dueDate;
  List<TaskModel> tasks;
  List<TaskModel> todo;
  List<TaskModel> ongoing;
  List<TaskModel> done;


  AssignmentModel(
    {
      this.id,
      @required this.title,
      @required this.description,
      @required this.leader,
      this.totalMarks,
      this.scoredMark,
      @required this.status,
      this.tasks,
      this.createdDate,
      this.dueDate,
      this.todo,
      this.ongoing,
      this.done,  
    }
  );

  Map<String,dynamic> toJson(){
    return {
      "title":this.title,
      "description":this.description,
      "leader":this.leader,
      "total_marks":this.totalMarks,
      "created_date": this.createdDate.toString(),
      "due_date":this.dueDate.toString(),
      "status":this.status.index,
    };
  }

  static AssignmentModel fromJson(Map<String,dynamic> json){
    return AssignmentModel(
      id: json['_id']['\$oid'],
      title: json['title'],
      description: json['description'],
      leader: json['leader'],
      totalMarks: json['total_marks'].toDouble(),
      scoredMark: json['scored_marks'] != null ? json['scored_marks'].toDouble() : null,
      status: json['status'] != null ? Status.values.elementAt(json['status']) : null,
      createdDate: json['created_date'] != null ? DateTime.parse(json['created_date']) : null,
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
  
    
    );
  }



}