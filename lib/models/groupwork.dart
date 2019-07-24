import 'package:flutter/cupertino.dart';


class Members{
  
}

class GroupworkModel{
  String id;
  String name;
  String description;
  String course;
  List<Members> members;

  GroupworkModel({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.course,
    @required this.members,
  });

  static GroupworkModel fromJson(Map<String,dynamic> data){

  }

  Map<String,dynamic> toJson(){

    Map<String,dynamic> data;
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['course'] = this.course;


  }
}