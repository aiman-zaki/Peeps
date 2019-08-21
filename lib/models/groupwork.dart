import 'package:flutter/cupertino.dart';


class Member{
  String id;


  Member({
    @required this.id
  });

  toJson(){
    Map<String,dynamic> data;

    data['id'] = this.id;

    return data;
  }
  
}

class GroupworkModel{
  String id;
  String creator;
  String name;
  String description;
  String course;
  List<dynamic> members;

  GroupworkModel({
    this.id,
    @required this.creator,
    @required this.name,
    @required this.description,
    @required this.course,
    @required this.members,
  });

  static GroupworkModel fromJson(Map<String,dynamic> data){
    return GroupworkModel(
      id: data['_id']['\$oid'],
      creator: data['creator'],
      name: data['name'],
      description: data['description'],
      course: data['course'],
      members: data['members'],
    );
  }

  Map<String,dynamic> toJson(){
    List temp;
    /*this.members.forEach((m) => ({
      temp.add(m.toJson())
    }));*/
    Map<String,dynamic> data;
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['course'] = this.course;
    data['members'] = this.members;
  
  return data;
  }
}