import 'package:flutter/cupertino.dart';
import 'package:peeps/models/task.dart';

class AssignmentModel{
  String id;
  String title;
  String description;
  String leader;
  String status;
  double totalMark;
  double scoredMark;
  List<TaskModel> todo;
  List<TaskModel> ongoing;
  List<TaskModel> done;


  AssignmentModel(
    {
      @required this.title,
      @required this.description,
      @required this.leader,
      this.totalMark,
      this.scoredMark,
      @required this.status,
      @required this.todo,
      @required this.ongoing,
      @required this.done,  
    }
  );

  static AssignmentModel fromJson(Map<String,dynamic> json){
    //TODO : Refractor looks like dummy dumb dumb
    List<TaskModel> _todo = [];
    List<TaskModel> _ongoing = [];
    List<TaskModel> _done = [];
    for(Map<String,dynamic> task in json['todo']){
   
      _todo.add(TaskModel.fromJson(task));
   
    }
    for(Map<String,dynamic> task in json['ongoing']){
      _ongoing.add(TaskModel.fromJson(task));
    }
    for(Map<String,dynamic> task in json['done']){
      _done.add(TaskModel.fromJson(task));
    }
    
    return AssignmentModel(
      title: json['title'],
      description: json['description'],
      leader: json['leader'],
      totalMark: json['totalMark'],
      scoredMark: json['scoredMark'],
      status: json['status'],
      //todo: json['todo'] != null ? json['todo'].map((task) => TaskModel.fromJson(task)).toList() : [],
      //ongoing: json['ongoing'] != null ? json['ongoing'].map((task) => TaskModel.fromJson(task)).toList() : [],
      //done: json['done'] != null ? json['done'].map((task) => TaskModel.fromJson(task)).toList() : [],
      todo: _todo,
      ongoing: _ongoing,
      done: _done,
    
    );
  }



}