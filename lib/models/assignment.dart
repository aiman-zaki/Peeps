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
    };
  }

  static AssignmentModel fromJson(Map<String,dynamic> json){
    //TODO : Refractor looks like dummy dumb dumb
    List<TaskModel> _todo = [];
    List<TaskModel> _ongoing = [];
    List<TaskModel> _done = [];
    /*if(json['todo'] != null){
      for(Map<String,dynamic> task in json['todo']){
        _todo.add(TaskModel.fromJson(task));
    
      }
    }
    if(json['ongoing'] != null){
      for(Map<String,dynamic> task in json['ongoing']){
        _ongoing.add(TaskModel.fromJson(task));
      }
    }
    if(json['done'] != null){
      for(Map<String,dynamic> task in json['done']){
        _done.add(TaskModel.fromJson(task));
      }
    }*/

    if(json['tasks'] != null){
      for(Map<String,dynamic> item in json['tasks']){
        TaskModel task = TaskModel.fromJson(item);
        if(task.status == 0){
          _todo.add(task);
        }
        if(task.status == 1){
          _ongoing.add(task);
        }
        if(task.status == 2){
          _done.add(task);
      
        }
      }
    }

    return AssignmentModel(
      id: json['_id']['\$oid'],
      title: json['title'],
      description: json['description'],
      leader: json['leader'],
      totalMarks: json['total_marks'],
      scoredMark: json['scored_marks'] != null ? json['scored_marks'] : null,
      status: json['status'] != null ? json['status'] : null,
      createdDate: json['created_date'] != null ? json['created_date'] : null,
      dueDate: json['due_date'] != null ? json['due_date'] : null,
      todo: _todo,
      ongoing: _ongoing,
      done: _done,
    
    );
  }



}