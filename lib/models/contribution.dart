import 'package:meta/meta.dart';
import 'package:peeps/enum/contribution_enum.dart';
class ContributionModel{
  final String id;
  //Person
  final String who;
  //Person 2 
  final String from;
  //[CRUD]
  final WhatEnum what;
  final DateTime when;
  //[Task|Assignment]
  final WhereEnum where;
  //Reasons?
  final String why;
  //[New|Update]
  final String how;

  final String assignmentId;
  final String taskId;

  String room;

  ContributionModel({
    this.id,
    @required this.who,
    @required this.from,
    @required this.what,
    @required this.where,
    @required this.when,
    @required this.why,
    @required this.how,
    @required this.assignmentId,
    @required this.taskId,
    this.room,
    
  });

  static ContributionModel fromJson(Map<String,dynamic> json){
    print(json);
    return ContributionModel(
  
      who: json['who'],
      from: json['from'],
      what: WhatEnum.values.elementAt(json['what']),
      when: DateTime.parse(json['when']),
      where: WhereEnum.values.elementAt(json['where']),
      why: json['why'],
      how: json['how'], 
      assignmentId: json['assignment_id'] != null ? json['assignment_id']['\$oid'] : null,
      taskId: json['task_id'] != null ? json['task_id']['\$oid'] : null,
 
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "who":this.who,
      "from":this.from,
      "what":this.what.index,
      "when":this.when.toString(),
      "where":this.where.index,
      "why":this.why,
      "how":this.how,
      "room":this.room,
      "assignment_id": this.assignmentId,
      "task_id":this.taskId,
    };
  }

  String display(){
    return "${getWhatEnumString(what)}${how != "" ? " "+how : ""} ${getWhereEnumString(where)} $why";
  }


} 