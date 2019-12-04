import 'package:flutter/widgets.dart';
import 'package:peeps/enum/approval_enum.dart';
import 'package:peeps/enum/task_status_enum.dart';
import 'package:peeps/screens/groupwork/kanban/task_review.dart';

class TaskModel{
  final String id;
  final String creator;
  final String assignTo;
  final String task;
  final String description;
  final DateTime createdDate;
  final DateTime assignDate;
  final DateTime dueDate;
  final DateTime lastUpdated;
  final TaskStatus status;
  final List<TaskItemsModel> items;
  final List<TaskReviewsModel> reviews;
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
    @required this.items,
    @required this.reviews,
    this.priority,
    this.seq,
  });
  static TaskModel fromJson(Map<String,dynamic> json){
    print(json);
    return TaskModel(
      id: json['_id']['\$oid'],
      creator: json['creator'],
      assignTo: json['assign_to'],
      task: json['task'],
      description: json['description'],
      assignDate: json['assign_date'] == null ? null : DateTime.parse(json['assign_date']),
      createdDate: DateTime.parse(json['created_date']),
      dueDate: json['due_date'] == null ? null : DateTime.parse(json['due_date']),
      lastUpdated: json['last_updated'] == null ? null : DateTime.parse(json['last_updated']),
      status: TaskStatus.values.elementAt(json['status']),
      items: json['items'] == null ? [] : json['items'].map((item) => TaskItemsModel.fromJson(item)).toList().cast<TaskItemsModel>(),
      reviews: json['reviews'] == null ? [] : json['reviews'].map((item) => TaskReviewsModel.fromJson(item)).toList().cast<TaskReviewsModel>(),
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

class TaskItemsModel{
  final String id;
  final String item;
  final Approval approval;
  final DateTime createdDate;

  TaskItemsModel({
    @required this.id,
    @required this.item,
    @required this.approval,
    @required this.createdDate,
  });

  static TaskItemsModel fromJson(Map<String,dynamic> json){
    return TaskItemsModel(
      id: json['_id']['\$oid'],
      item: json['item'],
      approval: json['approval'] !=  null ? Approval.values.elementAt(json['approval']) : Approval.tbd,
      createdDate: DateTime.parse(json['created_date'])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id": this.id,
      "item": this.item,
      "created_date": this.createdDate.toString(),
      "approval":this.approval.index,
    };
  }
}

class TaskReviewsModel{
  final String id;
  final String review;
  Approval approval;

  final DateTime createdDate;

  TaskReviewsModel({
    @required this.id,
    @required this.review,
    @required this.approval,

    @required this.createdDate,
  });

  static TaskReviewsModel fromJson(Map<String,dynamic> json){
    return TaskReviewsModel(
      id: json['_id']['\$oid'],
      review: json['review'],
      approval: json['approval'] !=  null ? Approval.values.elementAt(json['approval']) : Approval.tbd,

      createdDate: DateTime.parse(json['created_date'])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id": this.id,
      "review": this.review,
      "created_date": this.createdDate.toString(),
      "approval":this.approval.index,

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
  DateTime dueDate;
  DateTime createdDate;
  Approval approval;

  TaskRequestModel({
    @required this.id,
    @required this.taskId,
    @required this.requester,
    this.from,
    @required this.dueDate,
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
      dueDate: DateTime.parse(json['due_date']),
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
      "due_date":this.dueDate.toString()
    };
  }


}