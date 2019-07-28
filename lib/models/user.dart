import 'package:flutter/cupertino.dart';

class UserModel {
  String fname;
  String lname;
  String email;
  String contactNo;
  String programmeCode;
  List<dynamic> activeGroup;
  

  UserModel({
    @required this.fname,
    @required this.lname,
    @required this.email,
    @required this.contactNo,
    @required this.programmeCode,
    @required this.activeGroup,
  });

  static UserModel fromJson(Map<String,dynamic> json){
    return UserModel(
      fname: json['profile']['fname'],
      lname: json['profile']['lname'],
      email: json['email'],
      contactNo: json['profile']['contactNo'],
      programmeCode: json['profile']['programmeCode'],
      activeGroup: json['joined_group']
    );
  }

  
}