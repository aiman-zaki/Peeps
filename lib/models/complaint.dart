import 'package:meta/meta.dart';


class ComplaintModel{
  final String id;
  final String title;
  final String description;
  final String assignmentId;
  final String by;
  final String who;
  final DateTime createdDate;
  final DateTime resolvedDate;

  ComplaintModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.assignmentId,
    @required this.by,
    @required this.who,
    @required this.createdDate,
    @required this.resolvedDate,
  });

  static ComplaintModel fromJson(Map<String,dynamic> json){
    return ComplaintModel(
      id: json['_id']['\$oid'],
      title: json['title'],
      description: json['description'],
      assignmentId: json['assignment_id'] != null ? json['assignment_id']['\$oid'] : null,
      by: json['by'],
      who:json['who'],
      createdDate: DateTime.parse(json['created_date']),
      resolvedDate: json['resolved_date'] == null ? null : DateTime.parse(json['resolve_date']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "_id":this.id,
      "title":this.title,
      "description":this.description,
      "assignment_id":this.assignmentId,
      "by":this.by,
      "who":this.who,
      "created_date":this.createdDate.toString(),
      "resolve_date":this.resolvedDate == null? null : this.resolvedDate.toString(),
    };
  }

}