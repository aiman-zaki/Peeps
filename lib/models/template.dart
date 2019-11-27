import 'package:meta/meta.dart';
import 'package:peeps/models/assignment.dart';

class GroupworkTemplateModel{
  final String id;
  final String description;
  final List<AssignmentTemplateModel> assignments;
  GroupworkTemplateModel({
    @required this.id,
    @required this.description,
    @required this.assignments
  });
  static GroupworkTemplateModel fromJson(Map<String,dynamic> json){
    return GroupworkTemplateModel(
      id: json['_id']['\$oid'],
      description: json['description'],
      assignments: json['assignments'].map((assignment){
        return AssignmentTemplateModel.fromJson(assignment);
      }).toList().cast<AssignmentTemplateModel>()
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "description":this.description,
      "assignments":this.assignments.map((assignment){
        return assignment.toJson();
      }).toList()
    };
  }
}
class AssignmentTemplateModel{
  final String title;
  final String description;
  final double totalMarks;
  final DateTime startDate;
  final DateTime dueDate;
  List<TaskTemplateModel> tasks;
  AssignmentTemplateModel({
    @required this.title,
    @required this.description,
    @required this.totalMarks,
    @required this.tasks,
    @required this.startDate,
    @required this.dueDate
  });
  static AssignmentTemplateModel fromJson(Map<String,dynamic> json){
    return AssignmentTemplateModel(
      title: json['title'],
      description: json['description'],
      totalMarks: json['total_marks'].toDouble(),
      startDate: DateTime.parse(json['start_date']),
      dueDate: DateTime.parse(json['due_date']),
      tasks: json['tasks'].map((task){
        return TaskTemplateModel.fromJson(task);
      }).toList().cast<TaskTemplateModel>(),
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "title":this.title,
      "description":this.description,
      "total_marks":this.totalMarks,
      "start_date":this.startDate.toString(),
      "due_date":this.dueDate.toString(),
      "tasks":this.tasks.map((task){
        return task.toJson();
      }).toList()
    };
  }
}
class TaskTemplateModel{
  final String title;
  final String description;
  final int difficulty;
  TaskTemplateModel({
    @required this.title,
    @required this.description,
    @required this.difficulty,
  });
  
  static TaskTemplateModel fromJson(Map<String,dynamic> json){
    return TaskTemplateModel(
      title: json['title'],
      description: json['description'],
      difficulty: json['difficulty']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "title":this.title,
      "description":this.description,
      "difficulty":this.difficulty,
    };
  }
 
}