import 'package:flutter/cupertino.dart';
import 'package:peeps/enum/approval_enum.dart';
import 'package:peeps/enum/status_enum.dart';
import 'package:peeps/models/task.dart';

class AssignmentModel{
  final String id;
  final String title;
  final String description;
  final String leader;
  final Status status;
  final double totalMarks;
  final double scoredMark;
  final DateTime createdDate;
  final DateTime startDate;
  final DateTime dueDate;
  final double userPoint;
  final Approval approval;
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
      @required this.createdDate,
      @required this.startDate,
      @required this.dueDate,
      this.userPoint,
      this.approval,
      this.todo,
      this.ongoing,
      this.done,  
    }
  );

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "title":this.title,
      "description":this.description,
      "leader":this.leader,
      "total_marks":this.totalMarks,
      "created_date": this.createdDate.toString(),
      "start_date":this.startDate.toString(),
      "due_date":this.dueDate.toString(),
      "status":this.status.index,
      "approval":this.approval.index,
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
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
      userPoint: json['user_point'] != null ? json['user_point'].toDouble() : null,
      approval: json['approval'] != null ? Approval.values.elementAt(json['approval']) : null,
    
    );
  }



}