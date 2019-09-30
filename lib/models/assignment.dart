import 'package:flutter/cupertino.dart';
import 'package:peeps/models/task.dart';

class AssignmentModel{
  String id;
  String title;
  String description;
  String leader;
  String status;
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
      this.status,
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
    };
  }

  static AssignmentModel fromJson(Map<String,dynamic> json){
    //TODO : Refractor looks like dummy dumb dumb
   

    return AssignmentModel(
      id: json['_id']['\$oid'],
      title: json['title'],
      description: json['description'],
      leader: json['leader'],
      totalMarks: json['total_marks'].toDouble(),
      scoredMark: json['scored_marks'] != null ? json['scored_marks'].toDouble() : null,
      status: json['status'] != null ? json['status'] : null,
      createdDate: json['created_date'] != null ? DateTime.parse(json['created_date']) : null,
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
  
    
    );
  }



}