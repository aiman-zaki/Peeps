import 'package:flutter/cupertino.dart';
import 'package:peeps/models/assignment.dart';

class GroupworkModel{
  String id;
  String creator;
  String name;
  String description;
  String course;
  List<dynamic> members;
  List<AssignmentModel> assignments;

  GroupworkModel({
    this.id,
    @required this.creator,
    @required this.name,
    @required this.description,
    @required this.course,
    @required this.members,
    @required this.assignments,
  });

  static GroupworkModel fromJson(Map<String,dynamic> data){
    List<AssignmentModel> _assignments = [];
    //assignments: data['assignments'].map((assignment) => AssignmentModel.fromJson(assignment)).toList(), alt
    for(Map<String,dynamic> assingment in data['assignments']){
      _assignments.add(AssignmentModel.fromJson(assingment));
    }
    return GroupworkModel(
      id: data['_id']['\$oid'],
      creator: data['creator'],
      name: data['name'],
      description: data['description'],
      course: data['course'],
      members: data['members'],
      assignments: _assignments,
    
    );
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data;
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['course'] = this.course;
    data['members'] = this.members;
    return data;
  }
}